
#first let;s think about the meaning of each colm

#1: member_id
#2: loan_amnt
#5: term
#6: int_rate
#7: installment
#8: grade (include but perdict)
#11: emp_length
#12:home_ownership
#13: annual_inc
#14: is_inc_v

#19: loan_status (include but perdict) 

#36  fico_range_low
#37  fico_range_high
#38  inq_last_6mths (# credit inq in the last 6months)
#39  mths_since_last_delinq

#42  mths_since_recent_revol_delinq

#72 num_accts_ever_120_pd
#97 num_op_rev_tl




infile = open("LoanStats.csv")
outfile = open("LoanData-Small.csv","w")
for line in infile:
	clen = line.strip().rsplit(",")
	outfile.write(clen[1]+","+clen[2]+","+clen[5]+","+clen[6]+","+clen[7]+","+clen[8]+","+clen[12]+","+clen[13]+","+clen[14]+","+clen[19]+","+clen[37]+","+clen[38]+","+clen[39]+"\n")



infile.close()
outfile.close()

