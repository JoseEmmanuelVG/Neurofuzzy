%% Start of the code - JEVG
%% Clears the variables, closes all figures and clears the command window.
clear
close all
clc
%% Data definition
%Definition of the input data and the corresponding tags.
% 'P' contains the input features, and 'Tp' and 'Ta' are the target labels.
% 'P' is a 2x8 matrix where each column represents a sample and each row a sample feature (weight and ear length).
% 'Tp' and 'Ta' are 1x8 vectors where each element is the label corresponding to a sample in 'P'.
% The vector 'Tp' contains binary labels (0 and 1) for Perceptron, and 'Ta' contains labels of type -1 and 1 for Adaline.
P=[1    1   2   2   3   3   4   4;
   4    5   4   5   1   2   1   2];
Tp=[0   0   0   0   1   1   1   1];
Ta=[-1  -1  -1  -1  1   1   1   1];
% Gets the dimensions of 'P'. 'm' is the number of features and 'n' is the number of samples.
[m,n]=size(P);
%Definition of the learning constants and maximum errors allowed for model training.
alphaConstants=[4   8   16];
R=(1/n)*P*(P');
eigen=eig(R);
alpha=(1./(max(eigen)*alphaConstants));
ErrorPerochs=[20  50  100];
x = 0:0.1:5;

%% TRAINING: Train and visualization of models
for k=1:3
% Random initialization of weights and biases for each model.
    Wper=rand(1,2);         Bper=rand(1,1);
    Wadal_a4=rand(1,2);     Badal_a4=rand(1,1);
    Wadal_a8=rand(1,2);         Badal_a8=rand(1,1);
    Wadal_a16=rand(1,2);        Badal_a16=rand(1,1);

% Pre-assignment of the error vectors for each model.
    ErrorPer = zeros(1,n*ErrorPerochs(k));
    ErrorAdal_a4 = zeros(1,n*ErrorPerochs(k));
    ErrorAdal_a8 = zeros(1,n*ErrorPerochs(k));
    ErrorAdal_a16 = zeros(1,n*ErrorPerochs(k));
%% Training of the models using the input data and target labels.
    % Weights and biases of each model are updated based on their errors.
    for i=1:ErrorPerochs(k)
        for j=1:n
            idx = j+(n)*(i-1);
            % Perceptron training.
            ErrorPer(idx)=Tp(j)-hardlim(Wper*P(:,j)+Bper);
            Wper=Wper+ErrorPer(idx)*P(:,j)';
            Bper=Bper+ErrorPer(idx);
            
            % Adaline training with different learning rates.
            ErrorAdal_a4(idx)=Ta(j)-purelin(Wadal_a4*P(:,j)+Badal_a4);
            Wadal_a4=Wadal_a4+2*alpha(1)*ErrorAdal_a4(idx)*P(:,j)';
            Badal_a4=Badal_a4+2*alpha(1)*ErrorAdal_a4(idx);
            
            ErrorAdal_a8(idx)=Ta(j)-purelin(Wadal_a8*P(:,j)+Badal_a8);
            Wadal_a8=Wadal_a8+2*alpha(2)*ErrorAdal_a8(idx)*P(:,j)';
            Badal_a8=Badal_a8+2*alpha(2)*ErrorAdal_a8(idx);
            
            ErrorAdal_a16(idx)=Ta(j)-purelin(Wadal_a16*P(:,j)+Badal_a16);
            Wadal_a16=Wadal_a16+2*alpha(3)*ErrorAdal_a16(idx)*P(:,j)';
            Badal_a16=Badal_a16+2*alpha(3)*ErrorAdal_a16(idx);
        end
    end

%% Display of the models and their errors after training.
    z = 1/8:(1/8):ErrorPerochs(k);
    figure('Name','Training','NumberTitle','off')
    set(gcf, 'WindowState', 'maximized');  
    sgtitle('Practice 1 Neural Networks - JEVG', 'FontSize',20)      
    
% Subgraph for the Perceptron and Adaline with diferents values of alpha
        subplot(2,2,1:2)
        hold on
        plot(x,((Bper/Wper(2))/(-Bper/Wper(1)))*x+(-Bper/Wper(2)),'DisplayName','Perceptron','LineWidth',2)
        plot(x,((Badal_a4/Wadal_a4(2))/(-Badal_a4/Wadal_a4(1)))*x+(-Badal_a4/Wadal_a4(2)),'DisplayName','Adaline [Alpha = 1/(4 \lambda_{max})]','LineWidth',1.5)
        plot(x,((Badal_a8/Wadal_a8(2))/(-Badal_a8/Wadal_a8(1)))*x+(-Badal_a8/Wadal_a8(2)),'DisplayName','Adaline [Alpha = 1/(8 \lambda_{max})]','LineWidth',1.5)
        plot(x,((Badal_a16/Wadal_a16(2))/(-Badal_a16/Wadal_a16(1)))*x+(-Badal_a16/Wadal_a16(2)),'DisplayName','Adaline [Alpha = 1/(16 \lambda_{max})]','LineWidth',1.5)
        scatter(P(1,1:4),P(2,1:4),'o','red','DisplayName','Rabbits','MarkerFaceColor','red')
        scatter(P(1,5:8),P(2,5:8),'o','green','DisplayName','Bears','MarkerFaceColor','green')
            title(strcat(num2str(ErrorPerochs(k)),'Epochs'))
            l = legend;
            l.Location = 'eastoutside'; 
            xlabel('weight')
            ylabel('length of ears')
            hold off
        
% For the Perceptron, plot the number of errors over the training epochs.
        subplot(2,2,3)
        plot(z,ErrorPer,'color','#EDB120', 'DisplayName', 'Error','LineWidth',2)
        l = legend;
        l.Location = 'southeast';  
        title('Error Perceptron')
        xlabel('epoch')
        ylabel('error')
        
% For Adaline, plot the errors over the training epochs for the three values of alpha.
        subplot(2,2,4)
        hold on   
        plot(z, ErrorAdal_a4, 'DisplayName', 'Alpha = 1/(4 \lambda_{max})','LineWidth',0.5)    %    plot(z, ErrorAdal_a4, 'DisplayName', 'Alpha = $\frac{1}{4 \lambda_{\text{max}}}$')
        plot(z, ErrorAdal_a8, 'DisplayName', 'Alpha = 1/(8 \lambda_{max})','LineWidth',0.5)    %    plot(z, ErrorAdal_a4, 'DisplayName', 'Alpha = $\frac{1}{8 \lambda_{\text{max}}}$')
        plot(z, ErrorAdal_a16, 'DisplayName', 'Alpha = 1/(16 \lambda_{max})','LineWidth',0.5)  %    plot(z, ErrorAdal_a4, 'DisplayName', 'Alpha = $\frac{1}{16 \lambda_{\text{max}}}$')
        l = legend;
        l.Location = 'southeast';  
        title('Errors Adaline')
        xlabel('epoch')
        ylabel('error')
        hold off
end


%% TESTING: 
disp('To select the best option for alpha and epochs, propose output with 100 epochs and alpha with 16 as constant')
figure('Name','Testing','NumberTitle','off')
set(gcf, 'WindowState', 'maximized');  
sgtitle('Practice 1 Neural Networks - JEVG', 'FontSize',20)      

%  Allows the user to enter values for weight and ear length characteristics.
Ask="Y";
    while (Ask=="Y")
        weight=input('Introduce Weight: ');
        lears=input('Introduce Length of the ears: ');
        
    % The Perceptron model makes a prediction and displays an image depending on the prediction.
        subplot(2,2,1)
        a=hardlim(Wper*[weight;lears]+Bper);
        if a==0
            rgbImage = imread("Rabbit.png");
            imshow(rgbImage)
            xlabel('Rabbit')  
        else
            rgbImage = imread("Bear.jpeg");
            imshow(rgbImage)
            xlabel('Bear')  
        end
    title('Perceptron Result','Color','blue','FontSize',14)
    % The Adaline model makes a prediction and displays an image depending on the prediction.
        subplot(2,2,2)
        a=purelin(Wadal_a16*[weight;lears]+Badal_a16);
        if a>=0
            rgbImage = imread("Bear.jpeg");
            imshow(rgbImage)
            xlabel('Bear')  
        else
            rgbImage = imread("Rabbit.png");
            imshow(rgbImage)
            xlabel('Rabbit')  
        end
    title('Adaline Result','Color','red','FontSize',14)
        % Shows the decision line for Adaline and Perceptron on a graph, along with the test data points.
            subplot(2,2,3:4)
            hold on
            plot(x,((Bper/Wper(2))/(-Bper/Wper(1)))*x+(-Bper/Wper(2)),'DisplayName','Perceptron','LineWidth',2)
            plot(x,((Badal_a16/Wadal_a16(2))/(-Badal_a16/Wadal_a16(1)))*x+(-Badal_a16/Wadal_a16(2)),'DisplayName','Adaline [Alpha = 1/(16 \lambda_{max})]','LineWidth',1.5)
            scatter(P(1,1:4),P(2,1:4),'o','red','DisplayName','Rabbits','MarkerFaceColor','red')
            scatter(P(1,5:8),P(2,5:8),'o','green','DisplayName','Bears','MarkerFaceColor','green')
            scatter(weight, lears, 'x', 'black', 'DisplayName', 'Test Data');
            hold off
            title('Adaline and Perceprton Decision Boundary') 
            xlabel('Weight') 
            ylabel('Length of the ears') 
            ylim([0 6]) 
            grid on 
            set(gca,'YTick',0:0.5:6); 
            legend('Location','bestoutside') 

        Ask=input('Would you like to introduce another values? Yes(Y) / No(N) ','s');
    end




