close,clear

S=[1 1;2 1;3 1;4 1;1 2;3 2;1 3;2 3;3 3;4 2;4 3];%每一行一个状态
A=[1;2;3;4];%每一行一个动作，分别代表N,S,E,W
R=-0.02*ones(size(S,1),1);%取S的行，每一行代表该状态的reward
R(10)=-1;R(11)=1;
gamma=0.99;

load mp

% %   1   2   3   4   5   6   7   8   9   10  11
% mp=[.1  .1  0   0   .8  0   0   0   0   0   0;...  %line1 1N
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line2  S
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line3  E
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line4  W
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line5 2
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line6
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line7
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line8
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line9 3
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line10
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line11
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line12
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line13 4
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line14
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line15
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line16
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line17 5
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line18
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line19
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line20
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line21 6
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line22
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line23
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line24
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line25 7
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line26
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line27
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line28
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line29 8
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line30
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line31
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line32
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line33 9
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line34
%     .1  .1  0   0   .8  0   0   0   0   0   0;...  %line35
%     0   0   0   0   0   0   0   0   0   0   0];    %line36

% P=zeros(size(S,1),size(A,1),size(S,1));
% %第1个位置表示一个状态，第2个位置表示对应该状态采取的动作，第3个位置表示到达下一个状态的概率
% %如P(3,3,6)=0.1 表示在状态3（3 1）,采取动作3（E）到达状态6（3 2）的概率为0.1
% for state=1:size(P,1)
%     for action=1:size(P,2)
%         P(state,action)=mp(state+action);
%     end
% end

V=zeros(size(S,1),1);%取S的行，每一行代表该状态的Vs
V(10)=R(10);V(11)=R(11);
pi=zeros(size(S,1),1);%取S的行，每一行代表该状态的policy

%下面做迭代的时候只要做到9,10和11两个是固定的不动的
error=1e-15;
Vpre=V+1;
count=0;
while(max(abs(V-Vpre))>error) %IV方法
    Vpre=V;
    for index=1:9
        V(index)=R(index)+gamma*max(mp(size(A,1)*(index-1)+1:size(A,1)*index,:)*Vpre);
    end
    count=count+1;
end

for index=1:9
    [mavval maxpos]=max(mp(size(A,1)*(index-1)+1:size(A,1)*index,:)*V);
    pi(index)=maxpos;
end

show