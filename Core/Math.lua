local name, RUI = ...

RUI.Math = {}

RUI.Math.Lerp2 = function(p1, p2, t)
    return (1-t)*p1 + t*p2 -- Linear Interpolation
end

RUI.Math.Lerp3 = function(p1, p2, p3, t)
    if(t > 0.5) then
        t = (t * 2.0) - 1.0;
        return RUI.Math.Lerp2(p2[1], p3[1], t), RUI.Math.Lerp2(p2[2], p3[2], t), RUI.Math.Lerp2(p2[3], p3[3], t)
    end
    t = (t * 2.0)
    return RUI.Math.Lerp2(p1[1], p2[1], t), RUI.Math.Lerp2(p1[2], p2[2], t), RUI.Math.Lerp2(p1[3], p2[3], t)
end