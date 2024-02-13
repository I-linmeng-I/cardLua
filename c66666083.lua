--村规决斗：随意选卡
--双方开局这张卡里侧除外，然后把手卡任意张洗回卡组，然后抽出洗回数量的卡片

function c66666083.initial_effect(c)
	--Activate
	if c66666083.reg then return end
	c66666083.reg = true
	c66666083.used = 0
	c66666083.active = {[0]=false,[1]=false}
	local e1=Effect.GlobalEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetOperation(c66666083.activate)
	Duel.RegisterEffect(e1,0)
end

function c66666083.init(e)
	for tp = 0,1 do
		local g = Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,nil,66666083)
		local i = g:GetCount()
		if i > 0 then
			if c66666083.active[tp] then
				c66666083.active[tp+20] = true
			end
			c66666083.active[tp] = true
			c66666083.active[tp+10] = true

			Duel.Remove(g,POS_FACEDOWN,REASON_RULE)
			for p = 1,i do
				local top = Duel.GetDecktopGroup(tp,1):GetFirst()
				local newc = Duel.CreateToken(tp,top:GetOriginalCode())
				Duel.SendtoHand(newc,nil,REASON_RULE)
				Duel.Remove(top,POS_FACEDOWN,REASON_RULE)
			end
		end
		local g2 = Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_DECK,0,nil,66666083)
		if g2:GetCount() > 0 then
			if c66666083.active[tp] then
				c66666083.active[tp+20] = true
			end
			c66666083.active[tp] = true
			c66666083.active[tp+10] = true
			Duel.Remove(g2,POS_FACEDOWN,REASON_RULE)
		end
	end
end

function c66666083.activate(e,tp,eg,ep,ev,re,r,rp)
	c66666083.init(e)
	tp = Duel.GetTurnPlayer()
	
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 and c66666083.used == 1 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66666083,0))
		local g3 = Duel.SelectMatchingCard(tp,nil,tp,LOCATION_DECK,0,1,1,nil)
		Duel.MoveSequence(g3:GetFirst(),0)
		c66666083.used = 2
	end
	
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 and c66666083.used == 0 then 
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_HAND,0,1,63,nil)
		if g:GetCount()==0 then return end
		Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_RULE)
		Duel.ShuffleDeck(tp)
		Duel.BreakEffect()
		local g2=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_DECK,0,g:GetCount(),g:GetCount(),nil)
		Duel.SendtoHand(g2,nil,REASON_RULE)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(1-tp,nil,1-tp,LOCATION_HAND,0,1,63,nil)
		if g:GetCount()==0 then return end
		Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_RULE)
		Duel.ShuffleDeck(1-tp)
		Duel.BreakEffect()
		local g2=Duel.SelectMatchingCard(1-tp,nil,1-tp,LOCATION_DECK,0,g:GetCount(),g:GetCount(),nil)
		Duel.SendtoHand(g2,nil,REASON_RULE)
		c66666083.used = 1
	end

end

