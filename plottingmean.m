function [x_values, y_values] = plottingmean(readfigure)
% This function can be used to plot the average of a plotted figure without
% the original x and y data. 
% Original intent of the code was to plot the average line of several lines of unequal length. 
% The function takes a figure as input and produces the average plot,
% average x and y values as output. 
% Code by Linhchi Nguyen (linhchib.nguyen@gmail.com)

% get x and y values from figure
h = findobj(figure(readfigure), 'type', 'line');
x = get(h, 'xdata');
y = get(h, 'ydata');

% finding mininum and maximum values of y
abs_max_y = max(y{1});
abs_min_y = min(y{1});

for i = 1:length(y)
    
    if abs_max_y < max(y{i})
        abs_max_y = max(y{i});
    end
    
    if abs_min_y > min(y{i})
        abs_min_y = min(y{i});
    end
end

% generate a random value not in y
random_number = ((abs_max_y + 100) - (abs_max_y + 1)).*rand(1,1) + (abs_max_y + 1)

% finding mininum and maximum values of x
abs_max_x = max(x{1});
abs_min_x = min(x{1});

for i = 1:length(x)
    
    if abs_max_x < max(x{i})
        abs_max_x = max(x{i});
    end
    
    if abs_min_x > min(x{i})
        abs_min_x = min(x{i});
    end
end

x_values = abs_min_x:abs_max_x;



% adding random number values to y cells and concatenate all of them
A = repmat(random_number,1,length(x_values));
for j = 1:length(y)
    
    [aa,bb] = ismember([x{j,:}],x_values(1,:));
    y_new = repmat(random_number,1,length(x_values));
    y_new(bb) = [y{j}];
    A = vertcat(A, y_new);
    
end


% making all the random_number values into NaN
A(A==random_number) = NaN;

% calculating the mean for y values
y_values = nanmean(A);

% plotting
figure (gcf)
hold on
plot(x_values, y_values, 'k.-','MarkerSize',15,'linewidth',2)

    
