function[] = vars2Single()
    assignin('base','Ex',single(evalin('base','Ex')));
    assignin('base','Ey',single(evalin('base','Ey')));
    assignin('base','Ez',single(evalin('base','Ez')));
    assignin('base','Hx',single(evalin('base','Hx')));
    assignin('base','Hy',single(evalin('base','Hy')));
    assignin('base','Hz',single(evalin('base','Hz')));
    assignin('base','udx',single(evalin('base','udx')));
    assignin('base','udy',single(evalin('base','udy')));
    assignin('base','udz',single(evalin('base','udz')));
    assignin('base','edx',single(evalin('base','edx')));
    assignin('base','edy',single(evalin('base','edy')));
    assignin('base','edz',single(evalin('base','edz')));
end