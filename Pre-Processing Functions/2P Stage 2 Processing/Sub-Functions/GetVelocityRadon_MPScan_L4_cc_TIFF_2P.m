function [mpP,function_ID]=GetVelocityRadon_MPScan_L4_cc_TIFF_2P(fname,matfilename,window_time_size,angle_span, angle_resolution, max_v, channel,isinterleaved,Header);

% (filename,matfilename,windowsize,angle_span, angle_resolution,max_v,channel,the_scanmirrors);


theframes=[Header.notes.startframe Header.notes.endframe];
the_x=[Header.notes.xstart Header.notes.xstop];
the_decimate=Header.notes.the_decimate;
user_microns_per_pixel = Header.notes.microns_per_pixel;
%Modified version of GetVelocityRadon_MPScan_L4_cc to work with tiff files.
%PJD 11/2012
%filename,matfilename,...
%            [startframe endframe],windowsize,angle_span, angle_resolution,[xst%art(v) xstop(v)],...
%            the_decimate,max_v,user_microns_per_pixel,channel,the_scanmirrors)%funtion for loading *.MPD linescan files and performing the Radon transform on
%them in order to get the RBC velocity
%
%becase MPScan gets line scans in both directions, the frame is split into even
%and odd lines and velocity is extravted independently from each one and then averaged
%INPUTS:
%fname-filename
%matfilename-matalab file containg scan path etc
%theframes - beginning and ending frames
%windowtimesize - size (in sec) of the advancemt of the Radon window
%anglespan - how many degrees (+/-) to look in the adaptive search
%angle_resolution - fine angle resolution
%the_x - [left  right] bounds of which to extract from the frames in the X
%dimension
%the_decimate - factor by which to decimate the line scan in the X dimension
%max_v - time points above this absolute speed are clipped out and interpolated
%between the last and next valid time points
%the_objective - a number designating which objective is used isinterleaved
%user_microns_per_pixel-at 1x for current objective+microscope setup

%OUTPUTS
%thetas - angles of forward and back linescans

%V_hold - velocities of forward and back linescans
%v_out - 0.5*(v_forward+v_back)
%mpP -  a structure with the relevant data
%mpP.Header.notes substruct
%mpP.Ch1 first two frames from channel 1
%mpP.Blood_flow structure with velocity info etc.

%pjd 12/2012

%Open stream
function_ID = mfilename('fullpath');
rawinfo=imfinfo([fname '.tif']);%get the image info
% [Header.notes]=ReadMPScanTiffInfo([fname '.tif']);
mpP.Header.notes=Header.notes;
%Read header and take further action based on header information
mpP.num_frames = theframes(end)-theframes(1);%str2double(mpContent.Header.notes.Frame_Count);
mpP.xsize = str2double(mpP.Header.notes.xsize);
mpP.ysize = str2double(mpP.Header.notes.ysize);
mpP.xstart=the_x(1);
mpP.xstop=the_x(end);
frame_height=mpP.ysize;

% try
%     load(matfilename)
%     mpP.scanData=scanData;
% catch
%     mpP.scan_path=[];
%     %disp('matfile load full of FAIL')
% end

time_per_line=1/(Header.notes.frame_rate*Header.notes.ysize);
isinterleaved=1;



mpP.Header.notes.LineRate=1/time_per_line;
Fs_Blood_Flow=mpP.Header.notes.LineRate;
windowsizea=round(Fs_Blood_Flow*window_time_size);%*.25 %for interlevaed lines

%adapt windowsize to interleaved/not interleaved
if isinterleaved==1
    windowsize=8*round(windowsizea/8);
else
    windowsize=4*round(windowsizea/4);
end
mpP.Blood_flow.windowsize=windowsize;

%%%%basic stuff
nframes=theframes(2)-theframes(1)+1;
stepsize=.25*windowsize;
nlines=nframes*(mpP.Header.notes.ysize);
npoints=max(the_x)-min(the_x)+1;%str2num(mpP.Header.notes.Frame_Width);
nsteps=floor(nlines/stepsize)-3;
angles=(1:180);%parameters for initial search
angles_baseline=1:15:180;
angles_adaptive=[-angle_span:1:angle_span]; %angle range to look over
angles_fine=-1.75:angle_resolution:1.75; % fine grained search

n_adaptive_angles=length(angles_adaptive);
theta_low=5;%boundaries for for adaptivce theta
theta_high=n_adaptive_angles-5;
spread_matrix=zeros(1,length(angles));
spread_matrix_adaptive=zeros(2,-nsteps,length(angles_adaptive));
baseline_var=zeros(2,nsteps,length(angles_baseline));
spread_matrix_fine=zeros(2,nsteps,length(angles_fine));
thetas=zeros(2,nsteps);%the angle of the lines
data_var=zeros(nsteps,1);
data_hold=zeros(windowsize,npoints);

%data caching
framerate=round(mpP.Header.notes.LineRate/mpP.ysize);
nframes_to_cache=round(mpP.Header.notes.LineRate/mpP.ysize);
data_temp=LoadTiffConcatenate_2P([fname '.tif'],theframes);%load froma tiff file
data_cache = data_temp(:,the_x(1):the_decimate:the_x(2)-1);
mpP.Blood_flow.mean_BG=(mean(data_cache));
cached_lines=1:(nframes_to_cache*mpP.ysize);
use_lines=1:windowsize;

if isinterleaved==1
    data_hold=zeros(2,windowsize/2,length([the_x(1):the_decimate:the_x(2)-1]));
    data_hold(1,:,:)=double(data_cache(1:2:windowsize,1:the_decimate:end));
    data_hold(2,:,:)=double(data_cache(2:2:windowsize,end:-the_decimate:1));
else
    data_hold=zeros(1,windowsize,length([the_x(1):the_decimate:the_x(2)-1]));
    data_hold(1,:,:)=double(data_cache(1:windowsize,1:the_decimate:end));
end

line_counter=4*stepsize;%this is the end of the window

data_cachemean_forward=mean(data_cache);
if isinterleaved==1
    data_cachemean_backward=(fliplr(data_cachemean_forward));
end

if isinterleaved==1
    for k=1:nsteps
        frame_line_marker=line_counter;%find the new place in the frame
        data_hold(1,:,:)=double(data_cache(frame_line_marker-4*stepsize+1:2:frame_line_marker-1,1:the_decimate:end));
        data_hold(2,:,:)=double(data_cache(frame_line_marker+2-4*stepsize:2:frame_line_marker,end:-the_decimate:1));
        use_lines=use_lines+stepsize;
        %take out the local mean of the window
        the_t(k)=1+(k-1)*stepsize+windowsize/2;
        npoints_decimated=size(data_hold,3);
        for n=1:npoints_decimated
            data_hold_ms(1,:,n)=data_hold(1,:,n)-data_cachemean_forward(n);
            data_hold_ms(2,:,n)=data_hold(2,:,n)-data_cachemean_backward(n);
        end
        data_hold_ms=data_hold_ms-mean(data_hold_ms(:));
        if k==1
            radon_hold(1,:,:)=(radon(squeeze(data_hold_ms(1,:,:)),angles));
            radon_hold(2,:,:)=radon(squeeze(data_hold_ms(2,:,:)),angles);
            spread_matrix(1,:)=var(squeeze(radon_hold(1,:,:)));
            spread_matrix(2,:)=var(squeeze(radon_hold(2,:,:)));
            [m(1,:) the_theta(1,:)]=max(spread_matrix(1,k));
            [m(2,:) the_theta(2,:)]=max(spread_matrix(2,k));
            thetas(1,k)=angles(the_theta(1,:));
            thetas(2,k)=angles(the_theta(2,:));
            radon_hold_adaptive(1,:,:)=radon(squeeze(data_hold_ms(1,:,:)),-thetas(1,k)+angles_adaptive);
            radon_hold_adaptive(2,:,:)=radon(squeeze(data_hold_ms(2,:,:)),-thetas(2,k)+angles_adaptive);
            spread_matrix_adaptive(1,k,1)=max(var(squeeze(radon_hold_adaptive(1,:,:))));
            spread_matrix_adaptive(2,k,1)=max(var(squeeze(radon_hold_adaptive(2,:,:))));
            radon_hold_fine(1,:,:)=radon(squeeze(data_hold_ms(1,:,:)-mean(data_hold_ms(:))),thetas(1,k)+angles_fine);
            radon_hold_fine(2,:,:)=radon(squeeze(data_hold_ms(2,:,:)-mean(data_hold_ms(:))),thetas(2,k)+angles_fine);
            spread_matrix_fine(1,k,:)=squeeze(var(squeeze(radon_hold_fine(1,:,:))));
            spread_matrix_fine(2,k,:)=squeeze(var(squeeze(radon_hold_fine(2,:,:))));
            [m the_theta(1,:)]=max(squeeze(spread_matrix_fine(1,k,:)));
            [m the_theta(2,:)]=max(squeeze(spread_matrix_fine(2,k,:)));
            thetas(1,k)=thetas(1,k)+angles_fine(the_theta(1,:));
            thetas(2,k)=thetas(2,k)+angles_fine(the_theta(2,:));
            baseline_var(1,k,:)=var(radon(squeeze(data_hold_ms(1,:,:)),angles_baseline));
            baseline_var(2,k,:)=var(radon(squeeze(data_hold_ms(2,:,:)),angles_baseline));
        else
            thetas(1,k)=thetas(1,k-1);
            thetas(2,k)=thetas(2,k-1);
            radon_hold_adaptive(1,:,:)=radon(squeeze(data_hold_ms(1,:,:)),thetas(1,k-1)+angles_adaptive);
            radon_hold_adaptive(2,:,:)=radon(squeeze(data_hold_ms(2,:,:)),thetas(2,k-1)+angles_adaptive);
            spread_matrix_adaptive(1,k,:)=var(squeeze(radon_hold_adaptive(1,:,:)));
            spread_matrix_adaptive(2,k,:)=var(squeeze(radon_hold_adaptive(2,:,:)));
            [m the_theta(1,:)]=max(spread_matrix_adaptive(1,k,:));
            [m the_theta(2,:)]=max(spread_matrix_adaptive(2,k,:));
            baseline_var(1,k,:)=var(radon(squeeze(data_hold_ms(1,:,:)),angles_baseline));%figure out the average radon of the section for calculating S/N
            baseline_var(2,k,:)=var(radon(squeeze(data_hold_ms(2,:,:)),angles_baseline));%figure out the average radon of the section for calculating S/N
            %if the peak of the variance is at an extreme, redo for angles centered
            %around the peak
            
            
            while ((the_theta(1,:)<=theta_low)||(the_theta(1,:)>=theta_high))
                thetas(1,k)=thetas(1,k)+angles_adaptive(the_theta(1,:));
                radon_hold_adaptive(1,:,:)=radon(squeeze(data_hold_ms(1,:,:)), thetas(1,k)+angles_adaptive);
                spread_matrix_adaptive(1,k,:)=var(squeeze(radon_hold_adaptive(1,:,:)));
                [m the_theta(1,:)]=max(squeeze(spread_matrix_adaptive(1,k,:)));
            end
            while ((the_theta(2,:)<=theta_low)||(the_theta(2,:)>=theta_high))
                thetas(2,k)=thetas(2,k)+angles_adaptive(the_theta(2,:));
                radon_hold_adaptive(2,:,:)=radon(squeeze(data_hold_ms(2,:,:)), thetas(2,k)+angles_adaptive);
                spread_matrix_adaptive(2,k,:)=var(squeeze(radon_hold_adaptive(2,:,:)));
                [m the_theta(2,:)]=max(squeeze(spread_matrix_adaptive(2,k,:)));
            end
            
            baseline_var(1,k,:)=var(radon(squeeze(data_hold_ms(1,:,:)),angles_baseline));%
            baseline_var(2,k,:)=var(radon(squeeze(data_hold_ms(2,:,:)),angles_baseline));%
            thetas(1,k)=thetas(1,k)+angles_adaptive(the_theta(1,:));
            radon_hold_fine(1,:,:)=radon(squeeze(data_hold_ms(1,:,:)),thetas(1,k)+angles_fine);
            spread_matrix_fine(1,k,:)=var(squeeze(radon_hold_fine(1,:,:)));
            [m the_theta(1,:)]=max(spread_matrix_fine(1,k,:));
            thetas(1,k)=thetas(1,k)+angles_fine(the_theta(1,:));
            thetas(2,k)=thetas(2,k)+angles_adaptive(the_theta(2,:));
            radon_hold_fine(2,:,:)=radon(squeeze(data_hold_ms(2,:,:)),thetas(2,k)+angles_fine);
            spread_matrix_fine(2,k,:)=var(squeeze(radon_hold_fine(2,:,:)));
            [m the_theta(2,:)]=max(spread_matrix_fine(2,k,:));
            thetas(2,k)=thetas(2,k)+angles_fine(the_theta(2,:));
        end
        line_counter=line_counter+stepsize;
    end
end