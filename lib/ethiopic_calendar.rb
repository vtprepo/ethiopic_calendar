module EthiopicCalendar

	Amet_alem=-285019
	Amet_mihret=1723856
	Gregorian=1721426

	def jdn_from_gregorian(year,month,day)
		s   = ( year/4 ) - ( year - 1)/4 - ( year/100 ) + ( year - 1)/100 + ( year/ 400 ) - ( year - 1)/400
		t   = ( 14 - month)/12
		n   = 31 * t * (month - 1) + (1 - t) * (59 + s + 30 * (month - 3) + ( (3*month - 7)/ 5) ) + day - 1
		j=Gregorian + 365 * (year - 1) + ( year - 1)/4 - ( year - 1)/100 + ( year - 1)/400 + n
		return j
	end

	def jdn_to_ethiopian(jdn)
		if jdn >=Amet_mihret + 365
			era=Amet_mihret
		else
			era=Amet_alem
		end
		r = (jdn - era)%1461
		n = (r%365 ) + (365 * (r/1460 ))
		year = 4 * ((jdn - era)/1461) + r/365 - r/1460
		month = ( n/30 ) + 1
		day = (n%30 ) + 1

    case month
      when 1 then month="መስከረም"
      when 2 then month="ጥቅምት"
      when 3 then month="ህዳር"
      when 4 then month="ታህሳስ"
      when 5 then month="ጥር"
      when 6 then month="የካቲት"
      when 7 then month="መጋቢት"
      when 8 then month="ሚያዝያ"
      when 9 then month="ግንቦት"
      when 10 then month="ሰኔ"
      when 11 then month="ሐምሌ"
      when 12 then month="ነሃሴ"
      when 13 then month="ጳጉሜ"

    end
		date="#{month} #{day} #{year}"
	end
  def fromEthiopicToGregorian(in_date)
    return "NOT YET"
  end
  def fromGregorianToEthiopic(in_date)
    jdn = jdn_from_gregorian(in_date.year,in_date.month,in_date.day)

    return jdn_to_ethiopian(jdn)
  end

end
