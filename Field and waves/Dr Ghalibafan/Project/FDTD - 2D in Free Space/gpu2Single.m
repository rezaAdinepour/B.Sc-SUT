function[] = gpu2Single()
    assignin('base','Ex',gpuArray(evalin('base','Ex')));
    assignin('base','Ey',gpuArray(evalin('base','Ey')));
    assignin('base','Ez',gpuArray(evalin('base','Ez')));
    assignin('base','Hx',gpuArray(evalin('base','Hx')));
    assignin('base','Hy',gpuArray(evalin('base','Hy')));
    assignin('base','Hz',gpuArray(evalin('base','Hz')));
    assignin('base','udx',gpuArray(evalin('base','udx')));
    assignin('base','udy',gpuArray(evalin('base','udy')));
    assignin('base','udz',gpuArray(evalin('base','udz')));
    assignin('base','edx',gpuArray(evalin('base','edx')));
    assignin('base','edy',gpuArray(evalin('base','edy')));
    assignin('base','edz',gpuArray(evalin('base','edz')));
end