clc;clear;clf


myRobot = Robot;
sizeOfMap = [-20 20 -20 20];
%Number of cones in the map
Nc = 20;
posOfCones = zeros(2,Nc);

%Render the view
plot(myRobot.position(1), myRobot.position(2), "o")
axis(sizeOfMap)
axis equal
hold on;

%Rand Nc number of cones in the map
%x-values
a = sizeOfMap(1) + 1;
b = sizeOfMap(2) - 1;
posOfCones(1,:) = (b-a).*rand(Nc,1) + a;
%y-values
a = sizeOfMap(3) + 1;
b = sizeOfMap(4) - 1;
posOfCones(2,:) = (b-a).*rand(Nc,1) + a;
plot(posOfCones(1,:), posOfCones(2,:), "o")


myRobot.drawLineOfSight();

visibleCones = myRobot.uppdateVisibleCones(posOfCones)



