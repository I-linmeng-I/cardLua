--想抽啥抽啥
function c66666081.initial_effect(c)
	if c66666081.reg then return end
	c66666081.reg = true
	c66666081.tag = Duel.GetLP(0) > 8000
	c66666081.active = {[0]=false,[1]=false}
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PREDRAW)
	e2:SetOperation(c66666081.cfop)
	Duel.RegisterEffect(e2,0)
end
c66666081.tag = false
function c66666081.init(e)
	for tp = 0,1 do
		local g = Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,nil,66666081)
		local i = g:GetCount()
		if i > 0 then
			if c66666081.active[tp] then
				c66666081.active[tp+20] = true
			end
			c66666081.active[tp] = true
			c66666081.active[tp+10] = true

			Duel.Remove(g,POS_FACEDOWN,REASON_RULE)
			for p = 1,i do
				local top = Duel.GetDecktopGroup(tp,1):GetFirst()
				local newc = Duel.CreateToken(tp,top:GetOriginalCode())
				Duel.SendtoHand(newc,nil,REASON_RULE)
				Duel.Remove(top,POS_FACEDOWN,REASON_RULE)
			end
		end
		local g2 = Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_DECK,0,nil,66666081)
		if g2:GetCount() > 0 then
			if c66666081.active[tp] then
				c66666081.active[tp+20] = true
			end
			c66666081.active[tp] = true
			c66666081.active[tp+10] = true
			Duel.Remove(g2,POS_FACEDOWN,REASON_RULE)
		end
	end
end

function c66666081.cfop(e,tp,eg,ep,ev,re,r,rp)
	c66666081.init(e)
	tp = Duel.GetTurnPlayer()
	if not c66666081.active[tp]
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
		then return end
	c66666081.active[tp+10] = not c66666081.active[tp+10]
	if c66666081.tag and c66666081.active[tp+10] and c66666081.active[tp+20]==false then return end
	Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(66666081,1))
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(66666081,1))
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(66666081,0))
	local g = Duel.SelectMatchingCard(tp,nil,tp,LOCATION_DECK,0,1,1,nil)
	Duel.MoveSequence(g:GetFirst(),0)
end
