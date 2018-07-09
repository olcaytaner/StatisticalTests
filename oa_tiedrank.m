function [ranks] = oa_tiedrank(performance)
%[ranks] = tiedrank([1 1 2 2 0 0 0])
  [sorted, indexes] = sort(performance);
  for i = 1 : size(performance, 2)
    if i ~= 1
      if sorted(i) ~= sorted(i - 1)
        for j = 1 : count
          ranks(indexes(i - j)) = sumofranks / count;
        end
        sumofranks = i;
        count = 1;
      else
        sumofranks = sumofranks + i; 
        count = count + 1;
      end
    else
      sumofranks = 1;
      count = 1;
    end
  end
  for j = 1 : count
    ranks(indexes(size(performance, 2) - j + 1)) = sumofranks / count;
  end
end