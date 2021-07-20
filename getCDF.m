function[cdff,binLim]=getCDF()
axisHandle = gca;                         %handle to the axis that contains the histogram
histHandle = axisHandle.Children;         %handle to the histogram
histData = histHandle.Data;               %The first input to histogram()
binEdges = histHandle.BinEdges;           %The second input to histogram() (bin edges)
binLimits = histHandle.BinLimits;
binWidth = histHandle.BinWidth;
% Reproduce the figure
% figure
% histogram(histData, binEdges)
% If you're looking for the height of each bar:
barHeight = histHandle.Values;
cdff = cumsum(barHeight)/sum(barHeight);
xmin = binLimits(1);
xmax = binLimits(2);

binLim = xmin:xmax;
end