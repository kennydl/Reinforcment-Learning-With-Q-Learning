
clc, clear all, close all, warning('off');


%% ----- Globale variabler

global mode;        
global figure1;
global figure2;
figure1 = true;     
figure2 = true;
mode = '';


%% ----- Initialize paramters for simulations

i = 1;              % Total trials with Q-table method
j = 1;              % Total trials with Neural Network method
n1 = 1;             
n2 = 1;             
x1 = 0;             
x2 = 0;             
y1 = 0;             
y2 = 0;             
y3 = 0;             
y4 = 0;             
steps1 = 0;
steps2 = 0;
n_steps1 = 0;
n_steps2 = 0;
tot_steps1 = 0;
tot_steps2 = 0;
n_crash1 = 0;       % total number of crash with Q-table
n_crash2 = 0;       % total number of crash with Nueral-Network
reward1 = 0;        % reward of the Q-tabell
reward2 = 0;
total_reward1 = 0;  % total rewad of the Q-table
total_reward2 = 0;
cost_fun = 0;

% Select between static and dynamic obstacles
% dynamic obstacles = 'Dynamic', static obstacles = 'Static'
stadium_option1 = 'Static';
stadium_option2 = 'Static';

% Properties of the vehicle. scale: 1:10 cm
radius = 1.0;
wheel_radius = 0.325;
sensor_lengde = 10;
tot_rot = 0;


%% ----- Initialize Q-learing with Q-table 
state_space = createStateSpace(stadium_option1);    % state space
actions = actionList();                             % action list

%Find the size of the state space and the length of the action list
n_states = size(state_space,1);
n_actions = length(actions);

% Initialize Q-table and the model
Q_table = createQTable(n_states, n_actions);      %Q-table


%% ----- Initialize Q-learning with Neural Network

%Neural Network
input_layer_size = 5;
hidden_layer_size = 15;
output_layer_size = 3;

initial_w1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_w2 = randInitializeWeights(hidden_layer_size, output_layer_size);
nn_params = [initial_w1(:); initial_w2(:)];

%% ----- Initaliseringer av parametrer for Q-tabell og Neural Network metoden

%Initalisreringer av forskjellige parametrer
max_trials = 10000;     % Max Trials
max_steps = 600;        % Max steps
alpha1  = 0.5;          % Learning rate
alpha2  = 0.03;
gamma   = 0.9;          % Discount factor
epsilon = 0.95;         % Chance for random action
T1 = 24;                % The Paramater of the explore function with blotzmanns distribution
T2 = 24;


%% ----- Initaliseringer for GUI

%Plottets størrelse
xlimit = [-25, 25];
ylimit = [-25, 25];

% GUI
[h_plot1, h_plot2, h_text1, h_text2, h_button1, h_button2] = createSimulation(xlimit, ylimit, max_trials, max_steps,...
    alpha1, alpha2, gamma, epsilon, T1);
% Simulation Environments
subplot(h_plot1(1));
[h_poly1, h_circ1] = createStadium(stadium_option1);
h_car1 = createCarCircle(radius, sensor_lengde, 'b');

subplot(h_plot2(1));
[h_poly2, h_circ2] = createStadium(stadium_option2);
h_car2 = createCarCircle(radius, sensor_lengde, 'b');
