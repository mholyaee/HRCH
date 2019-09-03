function [RECHap]=FillGaps3_diploid(Haps,Conf,Thr,em)
%This function makes haplotypes based on the read assigns and majority
[SemiHap]=DelLowScoreDiploid(Haps,Conf,Thr);% Delete positions with low confidence i.e. less than Thr

[R,~]=size(SemiHap);
for r=1:R
    if em==1
    [RECHap(r,:)]=InterpolatePhase1_window_local_project4_geraci(SemiHap(r,:));
    else  
    [RECHap(r,:),remaingaps]=InterpolatePhase1_window_local_project4_geraci_em2(SemiHap(r,:));    
    end
    if ~isempty(remaingaps)
       RECHap(r,remaingaps)=Haps(r,remaingaps);
    end
end
end

