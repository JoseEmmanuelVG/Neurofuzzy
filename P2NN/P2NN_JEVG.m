%% Clear all the´previous data
clc
clear all

%% Definition of line segments for each feature of the face
N=[
  % Boca first part
-4 -3 -2 -4;
-2 -4 -2 -7;
-2 -7 -4 -3; 
  % Boca second part
4 -3 2 -4;
2 -4 2 -7;
2 -7 4 -3; 
 % Boca third part
-2 -4 2 -4;
2 -4 2 -5;
2 -5 -2 -5;
-2 -5 -2 -4;
  % Left eye 
 -5 3 -2 0; 
 -2 0 -3 0;
 -3 0 -5 1;
 -5 1 -5 3; 
  % Right eye
  5 3  2 0; 
  2 0  3 0;
  3 0  5 1;
  5 1  5 3; 
  % Nose
  0 0  1 -1;
  1 -1 0 -2;
  0 -2 -1 -1;
  -1 -1 0 0
  % Left eyebrow
 -5 4.5 -3.5 4.5; 
 -3.5 4.5 -3 3.5;
 -3 3.5 -5 3.5;
 -5 3.5 -5 4.5;
  % Right eyebrow
 5 4.5 3.5 4.5; 
 3.5 4.5 3 3.5;
 3 3.5 5 3.5;
 5 3.5 5 4.5;
]; 

%% Address of pointers for each line segment
PointersX=[ 
-0.1; -0.1; 0.1;       % Boca first part 
 0.1; 0.1; -0.1;       % Boca second part 
 -0.1; -0.1; 0.1; 0.1; % Boca third part 
 -0.1; 0.1; 0.1; 0.1;  % Left eye
 0.1; 0.1; -0.1; -0.1; % Right eye
 -0.1; -0.1; 0.1; 0.1; % Nose
-0.1; -0.1; 0.1; 0.1;  % Left eyebrow
 -0.1; 0.1; 0.1; -0.1  % Right eyebrow
]; 

%% Calculation of weights and biases for each line segment
for i=1:length(PointersX)
 m=(N(i,4)-N(i,2))/(N(i,3)-N(i,1));
 mw=-1/(m);
 if m==0
 W(i,:)=[0 PointersX(i)];
 else
 W(i,:)=[PointersX(i) (mw*PointersX(i))];
 end
 b(i,:)=-W(i,:)*[N(i,1);N(i,2)];
end

%% Definition of weights and biases for each face part
W1=[1 1 1];
b1=-2.5;
W2=[1 1 1];
b2=-2.5;
W3=[1 1 1 1];
b3=-3.5;
W4=[1 1 1 1];
b4=-3.5;
W5=[1 1 1 1];
b5=-3.5;
W6=[1 1 1 1];
b6=-3.5;
W7=[1 1 1 1];
b7=-3.5;
W8=[1 1 1 1];
b8=-3.5;

%% Definition of the circles representing the head and ears
h = 0; % center of circle x
k = 0; % center of the circle and
r = 8; % radius of the circle
h_ear_left = -7;    % center of left ear circle x
k_ear_left = 7;     % center of the circle of the left ear and
r_ear_left = 2.5;   % radius of the circle of the left ear
h_ear_right = 7;    % center of right ear circle x
k_ear_right = 7;    % center of the circle of the right ear and
r_ear_right = 2.5;  % radius of the right ear circle

%% Functions for calculating the distance from a point to a circle
circle_distance = @(x, y) r - sqrt((x - h).^2 + (y - k).^2);
left_ear_distance = @(x, y) r_ear_left - sqrt((x - h_ear_left).^2 + (y - k_ear_left).^2);
right_ear_distance = @(x, y) r_ear_right - sqrt((x - h_ear_right).^2 + (y - k_ear_right).^2);

%% Precálculo de las combinaciones de x e y para evitar calcularlo en cada iteración
[X,Y] = meshgrid(-10:0.1:10, -10:0.1:10);

%% Preasignación de las matrices para almacenar los resultados
plot_data_face = zeros(size(X));
plot_data_circle = zeros(size(X));

%% Cálculo de las activaciones para cada punto de la cuadrícula
for i=1:size(X,1)
    for j=1:size(X,2)
        %Cálculo vectorizado de a's
        a = hardlim(W*[X(i,j);Y(i,j)] + b); 

        a1 = hardlim(W1*sum(a(1:3)) + b1); 
        a2 = hardlim(W2*sum(a(4:6)) + b2);
        a3 = hardlim(W3*sum(a(7:10)) + b3);
        a4 = hardlim(W4*sum(a(11:14)) + b4);
        a5 = hardlim(W5*sum(a(15:18)) + b5);
        a6 = hardlim(W6*sum(a(19:22)) + b6);
        a7 = hardlim(W7*sum(a(23:26)) + b7);
        a8 = hardlim(W8*sum(a(27:30)) + b8);

        % Calculate the distance to the circle for each point on the mesh
        a9 = hardlim(circle_distance(X(i,j), Y(i,j)));
        % Calculate the distance to the ear circles for each point on the grid
        a10 = hardlim(left_ear_distance(X(i,j), Y(i,j)));
        a11 = hardlim(right_ear_distance(X(i,j), Y(i,j)));

        %Save the results, separating the face and the circle.
        plot_data_face(i,j) = any([a1 a2 a3 a4 a5 a6 a7 a8]);
        plot_data_circle(i,j) = a9;
        plot_data_ear_left(i,j) = a10;
        plot_data_ear_right(i,j) = a11;
    end
end

%% Draw the result
figure('Name','Face','NumberTitle','off')
hold on

%% Plot the points inside the black face
scatter(X(plot_data_face == 1), Y(plot_data_face == 1), 1, 'k'); 

%% Plot the points inside the circle in orange, but only where plot_data_face == 0
scatter(X((plot_data_circle == 1) & (plot_data_face == 0)), Y((plot_data_circle == 1) & (plot_data_face == 0)), 1, [1 0.5 0]); 

%% Plot the points inside the circle of the left ear in orange, but only where plot_data_face == 0 and plot_data_circle == 0
scatter(X((plot_data_ear_left == 1) & (plot_data_face == 0) & (plot_data_circle == 0)), Y((plot_data_ear_left == 1) & (plot_data_face == 0) & (plot_data_circle == 0)), 1, [1 0.5 0]);
%% Plot the points inside the circle of the right ear in orange, but only where plot_data_face == 0 and plot_data_circle == 0
scatter(X((plot_data_ear_right == 1) & (plot_data_face == 0) & (plot_data_circle == 0)), Y((plot_data_ear_right == 1) & (plot_data_face == 0) & (plot_data_circle == 0)), 1, [1 0.5 0]);

% Signature
text(8, -7, 'JEVG', 'FontSize', 10);
text(-8, -7, 'JEVG', 'FontSize', 10);
hold off















% 
% 
% clc
% clear all
% 
% N=[%Left eye 
%  -2 2 -6 2;
%  -2 2 -5 4;
%  -5 4 -6 2; 
%   %Right eye
%  2 2 6 2;
%  2 2 5 4;
%  5 4 6 2; 
%   %Nose
%  1 0 0 1;
%  0 -1 1 0;
%  0 1 -1 0;
%  -1 0 0 -1; 
%   %Mouth first part
%  -2 -3 -4 -2;
%  -4 -2 -3 -4;
%  -3 -4 -2 -5;
%  -2 -5 -2 -3; 
%   %Mouth second part
%  -2 -4 -2 -3;
%  -2 -3 2 -3;
%  2 -3 2 -4;
%  2 -4 -2 -4; 
%  %Mouth third part
%  2 -5 2 -3;
%  2 -3 4 -2;
%  4 -2 3 -4;
%  3 -4 2 -5]; 
% 
% 
% 
% PointersX=[ 0.1;
%  -0.1;
%  0.1; %Left eye
%  0.1;
%  0.1;
%  -0.1; %Right eye
%  -0.1;
%  -0.1;
%  0.1;
%  0.1; %Nose
%  -0.1;
%  0.1;
%  0.1;
%  -0.1; %Mouth first part
%  0.1;
%  -0.1;
%  -0.1;
%  0.1; %Mouth second part
%  0.1;
%  0.1;
%  -0.1;
%  -0.1]; %Mouth third part
% 
% 
% for i=1:length(PointersX)
%  m=(N(i,4)-N(i,2))/(N(i,3)-N(i,1));
%  mw=-1/(m);
%  if m==0
%  W(i,:)=[0 PointersX(i)];
%  else
%  W(i,:)=[PointersX(i) (mw*PointersX(i))];
%  end
%  b(i,:)=-W(i,:)*[N(i,1);N(i,2)];
% end
% 
% W1=[1 1 1];
% b1=-2.5;
% W2=[1 1 1];
% b2=-2.5;
% W3=[1 1 1 1];
% b3=-3.5;
% W4=[1 1 1 1];
% b4=-3.5;
% W5=[1 1 1 1];
% b5=-3.5;
% W6=[1 1 1 1];
% b6=-3.5;
% 
% h = 0; % circle center x
% k = 0; % circle center y
% r = 10; % circle radius
% 
% % Function to calculate the distance from a point to a circle
% circle_distance = @(x, y) r - sqrt((x - h).^2 + (y - k).^2);
% 
% % Pre-calculate the combinations of x and y to avoid calculating it in each iteration
% [X,Y] = meshgrid(-10:0.1:10, -10:0.1:10);
% 
% 
% % Pre-allocate the matrices to store the results
% plot_data_face = zeros(size(X));
% plot_data_circle = zeros(size(X));
% 
% for i=1:size(X,1)
%     for j=1:size(X,2)
%         % Vectorized calculation of a's
%         a = hardlim(W*[X(i,j);Y(i,j)] + b); 
% 
%         a1 = hardlim(W1*sum(a(1:3)) + b1); 
%         a2 = hardlim(W2*sum(a(4:6)) + b2);
%         a3 = hardlim(W3*sum(a(7:10)) + b3);
%         a4 = hardlim(W4*sum(a(11:14)) + b4);
%         a5 = hardlim(W5*sum(a(15:18)) + b5);
%         a6 = hardlim(W6*sum(a(19:22)) + b6);
% 
%         % Calculate the distance to the circle for each point in the mesh
%         a7 = hardlim(circle_distance(X(i,j), Y(i,j)));
% 
%         % Save the results, separating the face and the circle
%         plot_data_face(i,j) = any([a1 a2 a3 a4 a5 a6]);
%         plot_data_circle(i,j) = a7;
%     end
% end
% 
% % Draw the result
% figure('Name','Face','NumberTitle','off')
% hold on
% 
% % Plot the points inside the face black
% scatter(X(plot_data_face == 1), Y(plot_data_face == 1), 1, 'k'); 
% 
% % Plot the points inside the circle orange, but only where plot_data_face == 0
% scatter(X((plot_data_circle == 1) & (plot_data_face == 0)), Y((plot_data_circle == 1) & (plot_data_face == 0)), 1, [1 0.5 0]); 
% 
% hold off
% 
% 
% 


