	
function coeff = fitLogisticCurve(data, plotFit)

    x = unique(data(:, 3));
    y = zeros(size(x));
 
    for i = 1:numel(x)
        y(i) = size(data(data(:, 3) == x(i) & data(:, 4) == 1, :), 1) / max(data(:, 1));
    end
 
    model = fittype('1 / (1+exp(-a*(x-b)))', 'independent', 'x', 'dependent', 'y');
    opts = fitoptions('Method', 'NonlinearLeastSquares');
    opts.StartPoint = [mean(y) mean(x)];
    % Fit model to data.
    fitresult = fit(x, y, model, opts);
    if plotFit
        plot(fitresult,x,y)
    end
 
    coeff = coeffvalues(fitresult);
end