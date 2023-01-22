for i=1:size(Lick_time,2)
result=LickAnal_forTDT(Lick_time{i}.A,Lick_time{i}.B);
for k=1:length(result)
    Results{i,k}=result(k);
end

end
