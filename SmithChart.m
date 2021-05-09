classdef SmithChart < handle
    %SMITHCHART Creates an axis and puts a Smith chart in it
    %   Draw impedance and/or admittance lines as a conformal mapping from
    %   the impedance plane to the Gamma plane.
    
    properties
        hFig
        hAxes
        hPatch
        hZChart
        hYChart
        Theta = 2*pi*(0:0.01:1)
        hImpedanceChart
        hAdmittanceChart
    end
    
    methods
        function obj = SmithChart(hfig)
            obj.hFig = hfig;
            obj.createAxes();
            obj.createSmithChart();
        end
        function createImpedanceChart(obj)
        end
        function createAdmittanceChart(obj)
        end
        function createAxes(obj)
            %Create axes associated with this figure
            %Notes:
            %1) Limit axes to |Gamma| < 1 region
            %2) DataAspectRatioMode to manual keeps axes unit vectors equal on screen (I think)
            %3) Turn off axis lines
            %4) Ensure new objects are added to axis i.e. they do not replace old objects
            obj.hAxes = axes('Parent', obj.hFig, 'DataAspectRatioMode', 'manual', 'XLim', [-1.2 1.2], 'YLim', [-1.2 1.2], 'Visible', 'off',  'NextPlot', 'add','Position',[0.0 0.0 0.8 0.8]);
            
            %Show SmithChart using a white patch background
            obj.hPatch = patch('XData', cos(obj.Theta), 'YData', sin(obj.Theta),...
                'EdgeColor', 'black', 'FaceColor', 'white', ...
                'HandleVisibility', 'off', 'Parent', obj.hAxes);
            
        end
        function createSmithChart(obj)
            obj.hImpedanceChart = hggroup('Parent', obj.hAxes, 'Visible', 'off');
            obj.hAdmittanceChart = hggroup('Parent', obj.hAxes, 'Visible', 'off');
            
            %Resistance and conductance circles
            r = [0.2 0.5 1 2 5 10];
            [x, y] = obj.generateResistanceCircles(r);
            line(x, y, 'Color', 'black', 'Parent', obj.hImpedanceChart); %R
            line(-x, y, 'Color', 'red', 'Parent', obj.hAdmittanceChart); %G
            
            %Reactance and suscepttance circles
            x = [0.0 0.2 0.5 1 2 5 10];
            [xCo, yCo] = obj.generateReactanceCircles(x);
            line(xCo, yCo, 'Color', 'black', 'Parent', obj.hImpedanceChart); %+ve X
            line(xCo, -yCo, 'Color', 'black', 'Parent', obj.hImpedanceChart); %-ve X
            line(-xCo, yCo, 'Color', 'red', 'Parent', obj.hAdmittanceChart); %+ve B
            line(-xCo, -yCo, 'Color', 'red', 'Parent', obj.hAdmittanceChart); %-ve B
           
        end
        function [x, y] = generateResistanceCircles(obj,r)
            %Create parametric angle vector
            theta = 2*pi*(0:0.01:1).';
            for ii = 1:length(r)
                centreX = r(ii)/(1 + r(ii));
                centreY = 0;
                radius = 1/(1 + r(ii));
                x(:,ii) = centreX + radius*cos(theta);
                y(:,ii) = centreY + radius*sin(theta);
            end
        end
        function [xCo, yCo] = generateReactanceCircles(obj,reactance)
            %Create parametric angle vector
            y = [2 2 5  5 5 inf inf];
            y = inf*ones(size(reactance));
            for ii = 1:length(reactance)
                x = reactance(ii);
                %Determine min angle
                z0 = 1 + 1j/x;
                z = 2*pi+(1j*x-1)/(1j*x+1);
                max = angle(z-z0);
                %max = atan((1-x^2)/(2*x));
                %min = atan2(x^3-x,-2*x.^4);
                theta = linspace(pi/2,max,100);
                centreX = 1;
                centreY = 1/x;
                radius = 1/x;
                %                 xCo = centreX - radius*cos(theta);
                %                 yCo = centreY - radius*sin(theta);
                min = 2*atan(1/x);
                max = 2*atan((1+y(ii))/x);
                theta = linspace(min,max,100);
                xCo(:,ii) = centreX - radius*sin(theta);
                yCo(:,ii) = centreY + radius*cos(theta);
            end
            
        end
    end
end

