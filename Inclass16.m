% Inclass16

%GB comments
1 100 
2 100 won’t take off points but your peaks a and b should be in one peak cell array. 
3 100
overall 100

clear all
%The folder in this repository contains code implementing a Tracking
%algorithm to match cells (or anything else) between successive frames. 
% It is an implemenation of the algorithm described in this paper: 
%
% Sbalzarini IF, Koumoutsakos P (2005) Feature point tracking and trajectory analysis 
% for video imaging in cell biology. J Struct Biol 151:182?195.
%
%The main function for the code is called MatchFrames.m and it takes three
%arguments: 
% 1. A cell array of data called peaks. Each entry of peaks is data for a
% different time point. Each row in this data should be a different object
% (i.e. a cell) and the columns should be x-coordinate, y-coordinate,
% object area, tracking index, fluorescence intensities (could be multiple
% columns). The tracking index can be initialized to -1 in every row. It will
% be filled in by MatchFrames so that its value gives the row where the
% data on the same cell can be found in the next frame. 

%2. a frame number (frame). The function will fill in the 4th column of the
% array in peaks{frame-1} with the row number of the corresponding cell in
% peaks{frame} as described above.
%3. A single parameter for the matching (L). In the current implementation of the algorithm, 
% the meaning of this parameter is that objects further than L pixels apart will never be matched. 

% Continue working with the nfkb movie you worked with in hw4. 

% Part 1. Use the first 2 frames of the movie. Segment them any way you
% like and fill the peaks cell array as described above so that each of the two cells 
% has 6 column matrix with x,y,area,-1,chan1 intensity, chan 2 intensity

cell1 = ('nfkb_movie1.tif');
cell2 = ('nfkb_movie2.tif');
reader1 = bfGetReader(cell1);
reader2 = bfGetReader(cell2);
%cell1, chan1, time1
ind1a = reader1.getIndex(5,0,0)+1;
plane1a = bfGetPlane(reader1,ind1a);
[~,mask1a] = threshold(plane1a);
mask1a= imfill(mask1a,'holes');
stats1a = regionprops(mask1a,'Area');
r1a = min([stats1a.Area]);
mask1a = bwareaopen(mask1a,r1a);

%cell1, chan2, time1
ind2a = reader1.getIndex(5,1,0)+1;
plane2a = bfGetPlane(reader1,ind2a);
[~,mask2a] = threshold(plane2a);
mask2a= imfill(mask2a,'holes');
stats2a = regionprops(mask2a,'Area');
r2a = min([stats2a.Area]);
mask2a = bwareaopen(mask2a,r2a);

stats1a = regionprops(mask1a,plane1a,'Centroid','Area','MeanIntensity');
stats2a = regionprops(mask1a,plane2a,'Centroid','Area','MeanIntensity');
pos1a = cat(1,stats1a.Centroid);
area1a = cat(1,stats1a.Area);
mi1a = cat(1,stats1a.MeanIntensity);
mi2a = cat(1,stats2a.MeanIntensity);
num = -ones(size(area1a));
peak_a{1} = [pos1a,area1a,num,mi1a,mi2a];
%cell1, chan1, time2
ind3a = reader1.getIndex(5,0,1)+1;
plane3a = bfGetPlane(reader1,ind3a);
[~,mask3a] = threshold(plane3a);
mask3a= imfill(mask3a,'holes');
stats3a = regionprops(mask3a,'Area');
r3a = min([stats3a.Area]);
mask3a = bwareaopen(mask3a,r3a);

%cell1, chan2, time2
ind4a = reader1.getIndex(5,1,1)+1;
plane4a = bfGetPlane(reader1,ind4a);
[~,mask4a] = threshold(plane4a);
mask4a= imfill(mask4a,'holes');
stats4a = regionprops(mask4a,'Area');
r4a = min([stats4a.Area]);
mask4a = bwareaopen(mask4a,r4a);

stats3a = regionprops(mask3a,plane3a,'Centroid','Area','MeanIntensity');
stats4a = regionprops(mask3a,plane4a,'Centroid','Area','MeanIntensity');
pos3a = cat(1,stats3a.Centroid);
area3a = cat(1,stats3a.Area);
mi3a = cat(1,stats3a.MeanIntensity);
mi3a = cat(1,stats4a.MeanIntensity);
num = -ones(size(area3a));
peak_a{2} = [pos3a,area3a,num,mi3a,mi3a];

%cell2, chan1, time1
ind1b = reader2.getIndex(5,0,0)+1;
plane1b = bfGetPlane(reader2,ind1b);
[~,mask1b] = threshold(plane1b);
mask1b= imfill(mask1b,'holes');
stats1b = regionprops(mask1b,'Area');
r1b = min([stats1b.Area]);
mask1b = bwareaopen(mask1b,r1b);

%cell2, chan2, time1
ind2b = reader2.getIndex(5,1,0)+1;
plane2b = bfGetPlane(reader2,ind2b);
[~,mask2b] = threshold(plane2b);
mask2b= imfill(mask2b,'holes');
stats2b = regionprops(mask2b,'Area');
r2b = min([stats2b.Area]);
mask2b = bwareaopen(mask2b,r2b);

stats1b = regionprops(mask1b,plane1b,'Centroid','Area','MeanIntensity');
stats2b = regionprops(mask1b,plane2b,'Centroid','Area','MeanIntensity');
pos1b = cat(1,stats1b.Centroid);
area1b = cat(1,stats1b.Area);
mi1b = cat(1,stats1b.MeanIntensity);
mi2b = cat(1,stats2b.MeanIntensity);
num = -ones(size(area1b));
peak_b{1} = [pos1b,area1b,num,mi1b,mi2b];

%cell2, chan1, time2
ind3b = reader2.getIndex(5,0,1)+1;
plane3b = bfGetPlane(reader2,ind3b);
[~,mask3b] = threshold(plane3b);
mask3b= imfill(mask3b,'holes');
stats3b = regionprops(mask3b,'Area');
r3b = min([stats3b.Area]);
mask3b = bwareaopen(mask3b,r3b);

%cell2, chan2, time2
ind4b = reader2.getIndex(5,1,1)+1;
plane4b = bfGetPlane(reader2,ind4b);
[~,mask4b] = threshold(plane4b);
mask4b= imfill(mask4b,'holes');
stats4b = regionprops(mask4b,'Area');
r4b = min([stats4b.Area]);
mask4b = bwareaopen(mask4b,r4b);

stats3b = regionprops(mask3b,plane3b,'Centroid','Area','MeanIntensity');
stats4b = regionprops(mask3b,plane4b,'Centroid','Area','MeanIntensity');
pos3b = cat(1,stats3b.Centroid);
area3b = cat(1,stats3b.Area);
mi3b = cat(1,stats3b.MeanIntensity);
mi4b = cat(1,stats4b.MeanIntensity);
num = -ones(size(area3b));
peak_b{2} = [pos3b,area3b,num,mi3b,mi4b];

% Part 2. Run match frames on this peaks array. ensure that it has filled
% the entries in peaks as described above. 
matched_a = MatchFrames(peak_a,2,50);
matched_b = MatchFrames(peak_b,2,50);
% Part 3. Display the image from the second frame. For each cell that was
% matched, plot its position in frame 2 with a blue square, its position in
% frame 1 with a red star, and connect these two with a green line. 

% cell1
figure(1)
imshow(cat(3,imadjust(plane3a),imadjust(plane4a),zeros(size(plane4a))));
hold on;
for i = 1:min(size(matched_a{1}),size(matched_a{2}))
   if matched_a{1}(i,4)>0
       plot(peak_a{1}(i,1), peak_a{1}(i,2),'r*','MarkerSize',20)  
       plot(peak_a{2}(i,1),peak_a{2}(i,2),'bs','MarkerSize',20)
       plot([peak_a{1}(i,1) peak_a{2}(i,1)], [peak_a{1}(i,2) peak_a{2}(i,2)], 'g');
   end 
end 

% cell2
figure(2)
imshow(cat(3,imadjust(plane3b),imadjust(plane4b),zeros(size(plane3b))));
hold on;
for i = 1:min(size(matched_b{1}),size(matched_b{2}))
   if matched_b{1}(i,4)>0
       plot(peak_b{1}(i,1), peak_b{1}(i,2),'r*','MarkerSize',20)  
       plot(peak_b{2}(i,1),peak_b{2}(i,2),'bs','MarkerSize',20)
       plot([peak_b{1}(i,1) peak_b{2}(i,1)], [peak_b{1}(i,2) peak_b{2}(i,2)], 'g');
   end 
end 

