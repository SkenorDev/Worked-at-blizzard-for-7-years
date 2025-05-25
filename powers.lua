
function zeus(side,area,tcard)
  if side ==1 then
    for i, card in ipairs(eHand) do
    card.power=card.power-1
    end
  end
  if side ==2 then
    for i, card in ipairs(aHand) do
    card.power=card.power-1
    end
    end
  end
  
  function midas(side,area,tcard)
  for i, card in ipairs(areas[area].aPlay) do
    
    card.power=3
  end
  for i, card in ipairs(areas[area].ePlay) do
    
    card.power=3
    end
  end
  
  function aphrodite(side,area,tcard)
    if side ==1 then
    for i, card in ipairs(areas[area].ePlay) do
    
    card.power=card.power-1
  end
  end
     if side ==2 then
    for i, card in ipairs(areas[area].aPlay) do
    
    card.power=card.power-1
  end
  end
    
    
  end
  
  function hera(side,area,tcard)
     if side ==1 then
    for i, card in ipairs(aHand) do
    card.power=card.power+1
    end
  end
  if side ==2 then
    for i, card in ipairs(eHand) do
    card.power=card.power+1
    end
    end
  end
  
  function artemis(side,area,tcard)
     if side ==1 then
    if #areas[area].ePlay==1 then
      tcard.power= tcard.power+5
      end
  end
  if side ==2 then
    if #areas[area].aPlay==1 then
      tcard.power= tcard.power+5
    end
    end
  end
  
  function persephone(side,area,tcard)
    power=9999
    
    if side ==1 then
    for i, card in ipairs(aHand) do
    if card.power<=power then
      dcard=card
      power=card.power
      end
    end
      aDiscardHand(dcard)
    end
    if side ==2 then
      for i, card in ipairs(eHand) do
    if card.power<=power then
      dcard=card
      power=card.power
      end
    end
      eDiscardHand(dcard)
      
      end
    end
    
    
    function dionysus(side,area,tcard)
      if side ==1 then
      tcard.power=tcard.power+ (#areas[area].aPlay*2)
    end
    if side ==2 then
      tcard.power=tcard.power+ (#areas[area].ePlay*2)
      
    end
    end
    
   function hercules(side,area,tcard) 
     sotrue=true
    if side ==1 then
      for i, card in ipairs(areas[area].aPlay) do
        if card~=tcard then
        if card.power<tcard.power then
          sotrue=false
          end
        end
      end
      for i, card in ipairs(areas[area].ePlay) do
        if card~=tcard then
        if card.power<tcard.power then
          sotrue=false
          end
        end
      end
      tcard.power=tcard.power*2
    end
    if side ==2 then
   for i, card in ipairs(areas[area].aPlay) do
        if card~=tcard then
        if card.power<tcard.power then
          sotrue=false
          end
        end
      end
      for i, card in ipairs(areas[area].ePlay) do
        if card~=tcard then
        if card.power<tcard.power then
          sotrue=false
          end
        end
      end
      tcard.power=tcard.power*2
    end
  end
  function hephaestus(side,area,tcard)
    if side ==1 then
    if #aHand == 0 then
      return
      end
    for i = 1, 2 do
  card = aHand[math.random(1, #aHand)]
  card.cost=card.cost-1
end
    end
    if side ==2 then
    if #eHand == 0 then
      return
      end
  for i = 1, 2 do
  card = eHand[math.random(1, #eHand)]
  card.cost=card.cost-1
end
      end
    end
    
    
    function hades(side,area,tcard)
    if side ==1 then
   tcard.power=tcard.power + (2*aDiscard)
end
   
    if side ==2 then
    tcard.power=tcard.power + (2*eDiscard)
      end
    end