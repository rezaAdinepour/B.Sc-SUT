/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "E:/University/FPGA/HW/Subtractor/Sub.vhd";
extern char *IEEE_P_2592010699;

char *ieee_p_2592010699_sub_1697423399_503743352(char *, char *, char *, char *, char *, char *);
char *ieee_p_2592010699_sub_1735675855_503743352(char *, char *, char *, char *, char *, char *);
char *ieee_p_2592010699_sub_1837678034_503743352(char *, char *, char *, char *);
char *ieee_p_2592010699_sub_795620321_503743352(char *, char *, char *, char *, char *, char *);


static void work_a_1827167314_0064338728_p_0(char *t0)
{
    char t1[16];
    char t2[16];
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned char t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;

LAB0:    xsi_set_current_line(11, ng0);

LAB3:    t3 = (t0 + 1032U);
    t4 = *((char **)t3);
    t3 = (t0 + 5204U);
    t5 = (t0 + 1192U);
    t6 = *((char **)t5);
    t5 = (t0 + 5204U);
    t7 = ieee_p_2592010699_sub_1697423399_503743352(IEEE_P_2592010699, t2, t4, t3, t6, t5);
    t8 = (t0 + 1352U);
    t9 = *((char **)t8);
    t8 = (t0 + 5204U);
    t10 = ieee_p_2592010699_sub_1697423399_503743352(IEEE_P_2592010699, t1, t7, t2, t9, t8);
    t11 = (t1 + 12U);
    t12 = *((unsigned int *)t11);
    t13 = (1U * t12);
    t14 = (4U != t13);
    if (t14 == 1)
        goto LAB5;

LAB6:    t15 = (t0 + 3496);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memcpy(t19, t10, 4U);
    xsi_driver_first_trans_fast_port(t15);

LAB2:    t20 = (t0 + 3400);
    *((int *)t20) = 1;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    xsi_size_not_matching(4U, t13, 0);
    goto LAB6;

}

static void work_a_1827167314_0064338728_p_1(char *t0)
{
    char t1[16];
    char t2[16];
    char t3[16];
    char t9[16];
    char t14[16];
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    unsigned int t22;
    unsigned int t23;
    unsigned char t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;

LAB0:    xsi_set_current_line(12, ng0);

LAB3:    t4 = (t0 + 1192U);
    t5 = *((char **)t4);
    t4 = (t0 + 5204U);
    t6 = (t0 + 1352U);
    t7 = *((char **)t6);
    t6 = (t0 + 5204U);
    t8 = ieee_p_2592010699_sub_1697423399_503743352(IEEE_P_2592010699, t3, t5, t4, t7, t6);
    t10 = (t0 + 1032U);
    t11 = *((char **)t10);
    t10 = (t0 + 5204U);
    t12 = ieee_p_2592010699_sub_1837678034_503743352(IEEE_P_2592010699, t9, t11, t10);
    t13 = ieee_p_2592010699_sub_795620321_503743352(IEEE_P_2592010699, t2, t8, t3, t12, t9);
    t15 = (t0 + 1192U);
    t16 = *((char **)t15);
    t15 = (t0 + 5204U);
    t17 = (t0 + 1352U);
    t18 = *((char **)t17);
    t17 = (t0 + 5204U);
    t19 = ieee_p_2592010699_sub_795620321_503743352(IEEE_P_2592010699, t14, t16, t15, t18, t17);
    t20 = ieee_p_2592010699_sub_1735675855_503743352(IEEE_P_2592010699, t1, t13, t2, t19, t14);
    t21 = (t1 + 12U);
    t22 = *((unsigned int *)t21);
    t23 = (1U * t22);
    t24 = (4U != t23);
    if (t24 == 1)
        goto LAB5;

LAB6:    t25 = (t0 + 3560);
    t26 = (t25 + 56U);
    t27 = *((char **)t26);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    memcpy(t29, t20, 4U);
    xsi_driver_first_trans_fast_port(t25);

LAB2:    t30 = (t0 + 3416);
    *((int *)t30) = 1;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    xsi_size_not_matching(4U, t23, 0);
    goto LAB6;

}


extern void work_a_1827167314_0064338728_init()
{
	static char *pe[] = {(void *)work_a_1827167314_0064338728_p_0,(void *)work_a_1827167314_0064338728_p_1};
	xsi_register_didat("work_a_1827167314_0064338728", "isim/full_sub_isim_beh.exe.sim/work/a_1827167314_0064338728.didat");
	xsi_register_executes(pe);
}
