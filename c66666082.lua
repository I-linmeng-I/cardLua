--村规决斗：随意选卡
--把这张卡加入卡组后，双方开局这张卡里侧除外，然后把手卡任意张洗回卡组，然后抽出洗回数量的卡片


function c66666082.initial_effect(c)
	--Activate
	if c66666082.reg then return end
	c66666082.reg = true
	c66666082.used = {[0]=false,[1]=false}
	c66666082.active = {[0]=false,[1]=false}
	local e1=Effect.GlobalEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetTarget(c66666082.target)
	e1:SetOperation(c66666082.activate)
	Duel.RegisterEffect(e1,0)
end
function c66666082.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
end

function c66666082.init(e)
	for tp = 0,1 do
		local g = Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,nil,66666082)
		local i = g:GetCount()
		if i > 0 then
			if c66666082.active[tp] then
				c66666082.active[tp+20] = true
			end
			c66666082.active[tp] = true
			c66666082.active[tp+10] = true

			Duel.Remove(g,POS_FACEDOWN,REASON_RULE)
			for p = 1,i do
				local top = Duel.GetDecktopGroup(tp,1):GetFirst()
				local newc = Duel.CreateToken(tp,top:GetOriginalCode())
				Duel.SendtoHand(newc,nil,REASON_RULE)
				Duel.Remove(top,POS_FACEDOWN,REASON_RULE)
			end
		end
		local g2 = Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_DECK,0,nil,66666082)
		if g2:GetCount() > 0 then
			if c66666082.active[tp] then
				c66666082.active[tp+20] = true
			end
			c66666082.active[tp] = true
			c66666082.active[tp+10] = true
			Duel.Remove(g2,POS_FACEDOWN,REASON_RULE)
		end
	end
end

function c66666082.activate(e,tp,eg,ep,ev,re,r,rp)
	c66666082.init(e)
	tp = Duel.GetTurnPlayer()
	if c66666082.active[tp] and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 and c66666082.used[tp] == false then 
		c66666082.used[tp] = true
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_HAND,0,1,63,nil)
		if g:GetCount()==0 then return end
		Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_RULE)
		Duel.ShuffleDeck(tp)
		Duel.BreakEffect()
		local g2=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_DECK,0,g:GetCount(),g:GetCount(),nil)
		Duel.SendtoHand(g2,nil,REASON_RULE)
	end
	if c66666082.active[1-tp] and Duel.GetFieldGroupCount(1-tp,LOCATION_DECK,0)>0 and c66666082.used[1-tp] == false then 
		c66666082.used[1-tp] = true
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(1-tp,nil,1-tp,LOCATION_HAND,0,1,63,nil)
		if g:GetCount()==0 then return end
		Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_RULE)
		Duel.ShuffleDeck(1-tp)
		Duel.BreakEffect()
		local g2=Duel.SelectMatchingCard(1-tp,nil,1-tp,LOCATION_DECK,0,g:GetCount(),g:GetCount(),nil)
		Duel.SendtoHand(g2,nil,REASON_RULE)		
	end

end
