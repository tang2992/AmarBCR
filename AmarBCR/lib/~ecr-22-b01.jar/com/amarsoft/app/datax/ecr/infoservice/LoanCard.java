// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   LoanCard.java

package com.amarsoft.app.datax.ecr.infoservice;


public class LoanCard
{

	private String cardCode;
	private String passsword;
	private int status;
	private String countryCode;
	private String chineseName;
	private String englishName;
	private String organizationCode;
	private String licenceCode;
	private String licenceRegisterDate;
	private String licenceExpireDate;
	private int kind;
	private String areaCode;
	public static int STATUS_NORMAL = 0;
	public static int STATUS_CANCELD = 1;
	public static int STATUS_NOT_EXIST = 2;
	public static int STATUS_UNKNOWN = 9;

	public LoanCard(String code, String passwd)
	{
		cardCode = code;
		passsword = passwd;
		countryCode = null;
		chineseName = null;
		englishName = null;
		organizationCode = null;
		licenceCode = null;
		licenceRegisterDate = null;
		licenceExpireDate = null;
		areaCode = null;
	}

	public String getCardcode()
	{
		return cardCode;
	}

	public void setCardCode(String forCardCode)
	{
		cardCode = forCardCode;
	}

	public String getPasssword()
	{
		return passsword;
	}

	public void setPasssword(String forpasssword)
	{
		passsword = forpasssword;
	}

	public int getStatus()
	{
		return status;
	}

	public void setStatus(int forstatus)
	{
		status = forstatus;
	}

	public String getCountryCode()
	{
		return countryCode;
	}

	public void setCountryCode(String forcountryCode)
	{
		countryCode = forcountryCode;
	}

	public String getChineseName()
	{
		return chineseName;
	}

	public void setChineseName(String forchineseName)
	{
		chineseName = forchineseName;
	}

	public String getEnglishName()
	{
		return englishName;
	}

	public void setEnglishName(String forenglishName)
	{
		englishName = forenglishName;
	}

	public String getOrganizationCode()
	{
		return organizationCode;
	}

	public void setOrganizationCode(String fororganizationCode)
	{
		organizationCode = fororganizationCode;
	}

	public String getLicenceCode()
	{
		return licenceCode;
	}

	public void setLicenceCode(String forlicenceCode)
	{
		licenceCode = forlicenceCode;
	}

	public String getLicenceRegisterDate()
	{
		return licenceRegisterDate;
	}

	public void setLicenceRegisterDate(String forlicenceRegisterDate)
	{
		licenceRegisterDate = forlicenceRegisterDate;
	}

	public String getLicenceExpireDate()
	{
		return licenceExpireDate;
	}

	public void setLicenceExpireDate(String forlicenceExpireDate)
	{
		licenceExpireDate = forlicenceExpireDate;
	}

	public int getKind()
	{
		return kind;
	}

	public void setKind(int forkind)
	{
		kind = forkind;
	}

	public String getAreaCode()
	{
		return areaCode;
	}

	public void setAreaCode(String forareaCode)
	{
		areaCode = forareaCode;
	}

}
