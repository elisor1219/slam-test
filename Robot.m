classdef Robot < handle
    properties
        velocity = [0,0];
        position = [0,0];
        maxRange = 10;
        FOV = 145 * pi/180; %In rad
        rightFOV;
        leftFOV;
        currentLineOfSight;
        theta = (45) * pi/180; %In rad
        visibleCones;
    end

    methods
        %Constructor
        function self = Robot()
            self.rightFOV = -(self.FOV)/2 + self.theta;
            self.leftFOV = (self.FOV)/2 + self.theta;
        end

        function drawLineOfSight(self)
            r = self.maxRange;
            x = self.position(1);
            y = self.position(2);
            
            th = self.rightFOV:pi/50:self.leftFOV;
            x_circle = r * cos(th) + x;
            y_circle = r * sin(th) + y;
            xCord = [self.position(1) x_circle self.position(1)];
            yCord = [self.position(2) y_circle self.position(2)];
            self.currentLineOfSight = [xCord; yCord];
            plot(xCord, yCord)
        end

        %This will be with the coordinate system as zero from the car
        function visibleCones = uppdateVisibleCones(self, allCones)
            visibleCones = [0;0];
            %This is the number of visilbe cones.
            n = 0; 
            xPoly = self.currentLineOfSight(1,:);
            yPoly = self.currentLineOfSight(2,:);

            for i = 1:size(allCones,2)        
                if inpolygon(allCones(1,i),allCones(2,i),xPoly,yPoly)
                    n = n + 1;
                    visibleCones(1,n) = self.position(1) - allCones(1,i);
                    visibleCones(2,n) = self.position(2) - allCones(2,i);
                end
            end
            self.visibleCones = visibleCones;
        end

        function move(self, meter)
            self.position(1) = self.position(1) + cos(self.theta) * meter;
            self.position(2) = self.position(2) + sin(self.theta) * meter;
        end

        function rotate(self, theta)
            theta = mod(theta * pi/180, 2*pi);
            self.theta = mod(self.theta + theta, 2*pi);
            self.rightFOV = self.rightFOV + theta;
            self.leftFOV = self.leftFOV + theta;
        end

    end


end