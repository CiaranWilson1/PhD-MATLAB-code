classdef NeuralNetwork3 < handle
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    properties
        inputLayerSize
        hiddenLayerSize
        outputLayerSize
        W1
        W2
        A1 %Activation from Layer 2 (hidden) to Layer 3 (output)
        Z1 %Weighted input to Layer 2 (hidden layer)
        Z2 %Weighted input to Layer 3 (output layer)
        yHat
    end
%     properties (Dependent)
%         X
%     end
    
    methods
        function obj = NeuralNetwork3(in,hidden,out)
            obj.inputLayerSize = in + 1; %Add one for bias
            obj.hiddenLayerSize = hidden + 1; %Add one for bias
            obj.outputLayerSize = out;
            
            %No input to bias nueuron for Layer 2 (hidden layer)
            %so reduce by one
            obj.W1 = randn(obj.inputLayerSize,obj.hiddenLayerSize - 1);
            
            obj.W2 = randn(obj.hiddenLayerSize,obj.outputLayerSize );
            
%             obj.W1 = ones(obj.inputLayerSize,obj.hiddenLayerSize - 1);
%             
%             obj.W2 = ones(obj.hiddenLayerSize,obj.outputLayerSize );
        end
        
        function yHat = sim(obj,Xnb)
            %Form an input X with unit inputs from Xnb (No Bias)
            X = [Xnb, ones(size(Xnb,1),1)];
            
            %Find weighted inputs to Layer 1
            obj.Z1 = X*obj.W1;
            
            %Find the activation matrix going to the hidden layer
            A1nb = obj.f1(obj.Z1);
            
            %Add the bias to this layer
            obj.A1 = [A1nb, ones(size(A1nb,1),1)];
            
            %Find weighted inputs to Layer 2
            obj.Z2 = obj.A1*obj.W2;
            
            %Determine the output (could also call this A2)
            yHat = obj.f2(obj.Z2);
        end
        function yHat = sim2(obj,X,W)
            obj.setW(W);
            obj.Z1 = [X, ones(size(X,1),1)]*obj.W1;
            obj.A1 = [obj.f1(obj.Z1), ones(size(obj.Z1,1),1)];
            obj.Z2 = [obj.A1]*obj.W2;
            yHat = obj.f2(obj.Z2);
        end
        function val = f1(obj,z)
            val = tanh(z);
        end
        function val = f1prime(obj,z)
            val = (sech(z)).^2;
        end
        function val = f2(obj,z)
            val = z;
        end
        function val = f2prime(obj,z)
            val = ones(size(z));
        end
        function numGrad = computeNumericalGradient(obj,X)
            epsilon = 1e-6;
            W = obj.getW;
            numGrad = zeros(size(W));
            for ii = 1:length(W)
                perturb = zeros(size(W));
                perturb(ii,1) = epsilon;
                yp = obj.sim2(X,W + perturb);
                ym = obj.sim2(X,W - perturb);
                
                %Compute gradient
                numGrad(ii,1:size(X,1)) = -(yp - ym)./(2*epsilon);
                
                %Return weights to nominal values
                obj.setW(W);
            end
        end
        function J = jacobian(obj,X)
            obj.sim(X);
            dF_dW2 = -(obj.f2prime(obj.Z2)*ones(1,obj.hiddenLayerSize*obj.outputLayerSize)).*obj.A1;   
            temp1 = -(obj.f2prime(obj.Z2)*kron(obj.getW2, ones(1,obj.inputLayerSize))).*repmat([X ones(size(X,1),1)],1,obj.hiddenLayerSize-1);
            dF_dW1 = temp1.*kron(obj.f1prime(obj.Z1), ones(1,obj.inputLayerSize)); 
            J = [dF_dW1, dF_dW2];
        end
%         function Cap = diffCharge(obj,X,W1,W2)
%             obj.sim(X);
%             dZ2_VGS = W2(1)*f1prime(W1(1)*Vgs + W1(3)*Vgd)*W1(1) + W2(2)*f1prime(W1(2)*Vgs + W1(4)*Vgd)*W1(2);
%             dZ2_VGD = W2(1)*f1prime(W1(1)*Vgs + W1(3)*Vgd)*W1(3) + W2(2)*f1prime(W1(2)*Vgs + W1(4)*Vgd)*W1(4);
%             Cap = [dZ2_VGS, dZ2_VGD];
%         end
        function [W1,W2] = setW(obj,W)
            [W1,W2] = lin2mat(obj,W);
            obj.W1 = W1;
            obj.W2 = W2;
        end
        function W = getW(obj)
            W = [obj.W1(:); obj.W2(:)];
        end
%         function I = getSize(obj)
%             I = [obj.inputLayerSize(:); obj.hiddenLayerSize(:); obj.outputLayerSize];           
%         end
        function W = getW2(obj)
            Winter = obj.W2(:).'; %Convert to linear row vector
            W = Winter(1:end-1); %Don't return the bias weight
        end
        function [M1,M2] = lin2mat(obj,L)
            num1 = obj.inputLayerSize*(obj.hiddenLayerSize-1);
            %num2 = obj.hiddenLayerSize*obj.outputLayerSize;
            M1 = reshape(L(1:num1),obj.inputLayerSize,obj.hiddenLayerSize-1);
            M2 = reshape(L(num1+1:end),obj.hiddenLayerSize,obj.outputLayerSize);
        end
        function [dZ2_VGS, dZ2_VDS] = deriveCap(obj,X)
            dZ2_VGS = obj.W2.*((sech(obj.W1.*X)).^2)*obj.W1(1,:);
            dZ2_VDS = obj.W2.*((sech(obj.W1.*X)).^2)*obj.W1(2,:);
        end
    end
end

