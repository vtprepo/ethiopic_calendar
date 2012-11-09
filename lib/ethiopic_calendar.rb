# encoding: utf-8
module EthiopicCalendar
  # A Ruby implementation of Ethiopic Calendar based on the Mathematical algorithm
  # from http://ethiopic.org/Calendars/

  # Constants used
  public
  	Nmonths = 12
	MonthDays = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    #Ethiopic: Julian date offset
    JD_EPOCH_OFFSET_AMETE_MIHRET = 1723856  # ዓ/ም

    #Coptic : Julian date offset
    JD_EPOCH_OFFSET_COPTIC       = 1824665

	JD_EPOCH_OFFSET_GREGORIAN    = 1721426
    JD_EPOCH_OFFSET_AMETE_ALEM   = -285019  # ዓ/ዓ


    #Changes from in_date:EthiopicDate to GregorianDate
    #
    #@api public
    #@param  in_date always must be year,month, day in that order
    #@return GregorianDate is returned
    #@example fromEthiopicToGregorian(2004,5,21)
    
    def fromEthiopicToGregorian(year,month,day)
      #TODO : Handle Exceptions when there is a wrong input
      if (year <=0)
			era=JD_EPOCH_OFFSET_AMETE_ALEM
		else
			era=JD_EPOCH_OFFSET_AMETE_MIHRET
		end
		jdn = jdn_from_ethiopic( year, month, day,era )
		return gregorian_from_jdn(jdn)
    end

    #Changes from in_date:GregorianDate to EthiopicDate
    #
    #@api public
    #@param  year,month, day in that order
    #@return EthiopicDate is returned
    #@example fromEthiopicToGregorian(2012,5,21)
    def fromGregorianToEthiopic(year,month,day)
      #TODO : Handle Exceptions when there is a wrong input
      ethiopic_date = {:year=>-1,:month=>-1,:day => -1 }
      jdn = jdn_from_gregorian(year,month,day)
      if jdn >=JD_EPOCH_OFFSET_AMETE_MIHRET + 365
  			era= JD_EPOCH_OFFSET_AMETE_MIHRET
	  	else
		  	era= JD_EPOCH_OFFSET_AMETE_ALEM
  		end
		  r = (jdn - era).modulo(1461)
		  n = (r.modulo(365) ) + (365 * (r/1460 ))
  		ethiopic_date[:year] =4 * ((jdn - era)/1461) + r/365 - r/1460
	  	ethiopic_date[:month] =(n/30) + 1
		ethiopic_date[:day] =(n.modulo(30)) + 1
      return [ethiopic_date[:year],ethiopic_date[:month],ethiopic_date[:day]].join("-").to_s
    end


    #Date format for Ethiopic date
    #
    #@api public
    #@return a formated Ethiopic date string
    #@example ethiopic_date_format('2004-5-21') will be ጥር  21 ቀን  2004ዓ/ም
    def ethiopic_date_format(in_date)
        date_string=in_date.split("-")
	year=date_string[0].to_i
        month=date_string[1].to_i
        day=date_string[2].to_i
      month_name =""
      case month
        when 1 then month_name=" መስከረም "
        when 2 then month_name=" ጥቅምት "
        when 3 then month_name=" ህዳር "
        when 4 then month_name=" ታህሳስ "
        when 5 then month_name=" ጥር "
        when 6 then month_name=" የካቲት "
        when 7 then month_name=" መጋቢት "
        when 8 then month_name=" ሚያዝያ "
        when 9 then month_name=" ግንቦት "
        when 10 then month_name=" ሰኔ "
        when 11 then month_name=" ሐምሌ "
        when 12 then month_name=" ነሃሴ "
        when 13 then month_name=" ጳጉሜን "
      end
    	date="#{month_name} #{day} ቀን  #{year}ዓ/ም"
    end

    private
      #Calculates the jdn from given Gregorian calendar
      #
      #@api private
      #@return jdn
      def jdn_from_gregorian(year,month,day)
		    s   = ( year/4 ) - ( year - 1)/4 - ( year/100 ) + ( year - 1)/100 + ( year/ 400 ) - ( year - 1)/400
    		t   = ( 14 - month)/12
		    n   = 31 * t * (month - 1) + (1 - t) * (59 + s + 30 * (month - 3) + ( (3*month - 7)/ 5) ) + day - 1
    		j   = JD_EPOCH_OFFSET_GREGORIAN + 365 * (year - 1) + ( year - 1)/4 - ( year - 1)/100 + ( year - 1)/400 + n
		    return j
      end
      #Calculates the jdn from given Ethiopic calendar
      #
      #@api private
      #@return jdn
      def jdn_from_ethiopic(year,month,day,era)
        jdn = ( era + 365 ) + (365 * ( year - 1 )) + (year/4 ) + (30 * month) + (day - 31)
		return jdn
	  end
	  
	  def gregorian_from_jdn(jdn)
		date = {:year=>-1,:month=>-1,:day => -1 }
		r2000 = (jdn - JD_EPOCH_OFFSET_GREGORIAN)%730485
		r400  = (jdn - JD_EPOCH_OFFSET_GREGORIAN)%146097
		r100  = r400%36524
		r4    = r100%1461

		n = (r4%365) + 365*(r4/1460)
		s = r4/1095
		aprime = 400 * ((jdn - JD_EPOCH_OFFSET_GREGORIAN)/146097)+ (100 *( r400/36524 ))+ (4 *( r100/1461 ))+ ( r4/365 ) - (r4/1460 ) - (r2000/730484 )
		date[:year]   = aprime + 1
		t = (364+s-n)/306
		date[:month]  = t * ((n/31) + 1 ) + ( 1 - t ) * (((5*(n-s)+13)/153) +  1 )
		n +=  1 - (r2000/730484)
		date[:day] = n


	   if ( (r100 == 0) && (n == 0) && (r400 != 0) )
			date[:month] = 12
			date[:day] = 31
		else
			MonthDays[2] = isGregorianLeap(date[:year]) ? 29 : 28
			for i in 1..Nmonths
				if (n <= MonthDays[i])
					date[:day] = n
					break
				end
				n -= MonthDays[i]
			end
		end
		gregorian_date=Date.new(date[:year],date[:month],date[:day])
		
		return gregorian_date
	end
	
	def isGregorianLeap(year)
		return (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0))
	end
	    
end
