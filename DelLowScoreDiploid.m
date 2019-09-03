function [SemiHap]=DelLowScoreDiploid(varargin)
if nargin==3
    Haps=varargin{1};
    Conf=varargin{2};
    Thr=varargin{3};
end
[R,C]=size(Haps);
b=1;
if nargin==3
    for r=1:R
        for c=1:C
            if Conf(r,c)<=Thr
                Haps(r,c)='-';
                b=b+1;
            end
        end
    end
end
SemiHap=Haps;
end

