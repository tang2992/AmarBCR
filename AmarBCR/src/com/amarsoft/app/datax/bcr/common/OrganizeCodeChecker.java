package com.amarsoft.app.datax.bcr.common;


public class OrganizeCodeChecker
{
  public static void main(String[] args)
  {
    System.out.println("1" + organizeCodeCheck("MA28A0N2-5"));
  }

  public static boolean organizeCodeCheck(String orgCode) {
    byte[] financecode = orgCode.getBytes();
    int[] w_i = new int[8];
    int[] c_i = new int[8];
    int s = 0;
    String code = new String(financecode);
    if ((code.equals("00000000-0")) || (orgCode.trim().length() != 10))
      return false;
    w_i[0] = 3;
    w_i[1] = 7;
    w_i[2] = 9;
    w_i[3] = 10;
    w_i[4] = 5;
    w_i[5] = 8;
    w_i[6] = 4;
    w_i[7] = 2;
    if (financecode[8] != 45)
      return false;

    for (int i = 0; i < 10; ++i)
    {
      int c = financecode[i];
      if ((c <= 122) && (c >= 97))
        return false;
    }

    for(int j = 0; j < 8; j++){
        if(financecode[j] >= 65 && financecode[j] <= 90)
        	c_i[j] =  (financecode[j] - 65) + 10;
        else if(financecode[j] >= 48 && financecode[j] <= 57)
        	c_i[j] =  financecode[j] - 48;
        else
            return false;
        s += w_i[j] * c_i[j];
    }

    int c = 11 - s % 11;
    return (((financecode[9] == 88) && (c == 10)) || ((c == 11) && (financecode[9] == 48)) || (c == financecode[9] - 48));
  }
}