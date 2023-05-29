function createfigure(X1, YMatrix1)
%CREATEFIGURE(X1, YMatrix1)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data

%  Auto-generated by MATLAB on 01-Mar-2023 20:29:03

% Create figure
figure1 = figure;

% Create axes
axes1 = axes;
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(X1,YMatrix1,'LineWidth',2);
set(plot1(1),'DisplayName','Trapezoidal 1');
set(plot1(2),'DisplayName','Trapezoidal 2');
set(plot1(3),'DisplayName','Triangular',...
    'Color',[0.466666666666667 0.674509803921569 0.188235294117647]);

% Create ylabel
ylabel('μ(x)','FontWeight','bold');

% Create xlabel
xlabel('x','FontWeight','bold');

% Create title
title(['Figure 1: Universe (0 200), step=0.5            ';'Membership Functions: Triangular and Trapezoidal']);

box(axes1,'on');
grid(axes1,'on');
hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'OuterPosition',[0 0 1 1]);
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.733676978402941 0.747765009126139 0.159793811629421 0.101532564309365]);

% Create textbox
annotation(figure1,'textbox',...
    [0.30798969072165 0.0785335937692491 0.0438144320679694 0.0488188966522067],...
    'Color',[0.466666666666667 0.674509803921569 0.188235294117647],...
    'String',{'a'},...
    'FontWeight','bold',...
    'FontSize',12,...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.5 0.122594896451241 0.0438144320679694 0.0488188966522067],...
    'Color',[0.466666666666667 0.674509803921569 0.188235294117647],...
    'String','a',...
    'FontWeight','bold',...
    'FontSize',12,...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.438144329896907 0.112026821122315 0.0438144320679693 0.0593869719811326],...
    'Color',[0 0.447058823529412 0.741176470588235],...
    'String','d',...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.605670103092783 0.115858238746835 0.0438144320679693 0.0593869719811326],...
    'Color',[0.635294117647059 0.0784313725490196 0.184313725490196],...
    'String','a',...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.695876288659793 0.0689550497079458 0.0438144320679694 0.0488188966522067],...
    'Color',[0.466666666666667 0.674509803921569 0.188235294117647],...
    'String','c',...
    'FontWeight','bold',...
    'FontSize',12,...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.72680412371134 0.861068966716182 0.0438144320679694 0.0593869719811326],...
    'Color',[0.635294117647059 0.0784313725490196 0.184313725490196],...
    'String','b',...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.315721649484536 0.867816091954023 0.0412371134020624 0.0603026819923271],...
    'Color',[0 0.447058823529412 0.741176470588235],...
    'String','c',...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor','none');

