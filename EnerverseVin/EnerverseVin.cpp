// EnerverseVin.cpp : Defines the exported functions for the DLL application.
//

#include "stdafx.h"


#define GMEXPORT extern "C" __declspec (dllexport)

GMEXPORT double testFunction(double a, double b)
{
	return a + b;
}