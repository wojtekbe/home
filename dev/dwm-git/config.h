/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int gappx     = 3;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Terminess Powerline:size=8", "Stlarch_wb:size=8" };
static const char dmenufont[]       = "Terminess Powerline:size=8";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#5F5FFF";
static const char col_black[]       = "#000000";
static const char col_red[]         = "#ff0000";
static const char col_yellow[]      = "#ffff00";
static const char col_white[]       = "#ffffff";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
	[SchemeWarn] =	 { col_black, col_yellow, col_red },
	[SchemeUrgent]=	 { col_white, col_red,    col_red },
};

/* tagging */
static const char *tags[] = { "\uE187", "\uE188", "\uE189", "\uE18A" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title         tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,         0,            0,           -1 },
	{ "Firefox",  NULL,       NULL,         1,            0,           -1 },
	{ "Chromium", NULL,       NULL,         1,            0,           -1 },
	{ "Mousepad", NULL,       NULL,         0,            1,           -1 },
	{ "Leafpad",  NULL,       NULL,         0,            1,           -1 },
	{ "Vlc",      NULL,       NULL,         0,            0,           -1 },
	{ "MPlayer",  NULL,       NULL,         0,            1,           -1 },
	{ "feh",      NULL,       NULL,         0,            1,           -1 },
	{ "Sxiv",     NULL,       NULL,         0,            1,           -1 },
	{ "Spotify",  NULL,       NULL,         (1<<3),       0,           -1 },
	{ "Xsane",    NULL,       NULL,         0,            1,           -1 },
	{ NULL,       NULL,       "scratchpad", 0xFF,         1,           -1 },
	{ NULL,       NULL,       "broken",     0,            1,           -1 }, /* gstreamer xvimagesink */
	{ "Display",  NULL,       NULL,         0,            1,           -1 },
	{ NULL,       NULL,       "Telegram",   (1<<3),       0,           -1 },
	{ NULL,       NULL,       "Wine",       0,            1,           -1 },
    { NULL,       NULL,       "Slack | mini panel",
                                            (1<<3),       1,           -1 },
	{ "Pcmanfm",  NULL,       NULL,         0,            1,           -1 },
	{ "Thunar",   NULL,       NULL,         0,            1,           -1 },
	{ "Pavucontrol",NULL,     NULL,         0,            1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "\uE002",      tile },    /* first entry is default */
	{ "\uE006",      NULL },    /* no layout function means floating behavior */
	{ "\uE000",      monocle },
	{ "TTT",         bstack },
	{ "===",         bstackhoriz },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ Mod4Mask,                     KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu-my", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", NULL };

/* volume */
static const char *volupcmd[]  =     { "dwm-volume", "-i", "2", NULL };
static const char *voldowncmd[]  =   { "dwm-volume", "-d", "2", NULL };

/* spotify */
static const char *spotifytogglecmd[]  = { "spotkey", "t", NULL };
static const char *spotifynextcmd[]  =   { "spotkey", "n", NULL };
static const char *spotifyprevcmd[]  =   { "spotkey", "p", NULL };

/* backlight */
static const char *backlightup[] = { "xbacklight", "-inc", "10%", NULL };
static const char *backlightdown[] = { "xbacklight", "-dec", "10%", NULL };

/* shutdown (for power button) */
static const char *exitdmenucmd[] = { "dmenu-exit", "-fn", dmenufont, "-nb", "#ff0000", "-nf", "#000000", "-sb", "#000000", "-sf", col_gray4, NULL };

static Key keys[] = {
	/* modifier             key                      function        argument */
	{ MODKEY,               XK_b,                    togglebar,      {0} },
	{ MODKEY,               XK_j,                    focusstack,     {.i = +1 } },
	{ MODKEY,               XK_k,                    focusstack,     {.i = -1 } },
	{ MODKEY,               XK_w,                    focusstack,     {.i = +1 } },
	{ MODKEY,               XK_Tab,                  focusstack,     {.i = +1 } },
	{ MODKEY,               XK_s,                    focusstack,     {.i = -1 } },
	{ MODKEY,               XK_equal,                incnmaster,     {.i = +1 } },
	{ MODKEY,               XK_minus,                incnmaster,     {.i = -1 } },
	{ MODKEY|ShiftMask,     XK_equal,                setmfact,       {.f = 0 } },
	{ MODKEY,               XK_d,                    setmfact,       {.f = +0.05} },
	{ MODKEY,               XK_a,                    setmfact,       {.f = -0.05} },
	{ MODKEY,               XK_t,                    setlayout,      {.v = &layouts[0]} },
	{ MODKEY,               XK_f,                    setlayout,      {.v = &layouts[1]} },
	{ MODKEY,               XK_m,                    setlayout,      {.v = &layouts[2]} },
	{ MODKEY,               XK_g,                    setlayout,      {.v = &layouts[3]} },
	{ MODKEY,               XK_0,                    view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,     XK_0,                    tag,            {.ui = ~0 } },
	{ MODKEY,               XK_comma,                focusmon,       {.i = -1 } },
	{ MODKEY,               XK_period,               focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,     XK_comma,                tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,     XK_period,               tagmon,         {.i = +1 } },
	{ MODKEY|ShiftMask,     XK_q,                    quit,           {0} },
	{ MODKEY,               XK_Return,               zoom,           {0} },
	{ MODKEY,               XK_x,                    killclient,     {0} },

	{ 0,                    XF86XK_PowerOff,         spawn,          {.v = exitdmenucmd } },
	{ 0,                    XK_F12,                  spawn,          SHCMD("scratchpad") },
	{ Mod4Mask,             XK_e,                    spawn,          SHCMD("thunar /tmp") },
	{ MODKEY,               XK_F2,                   spawn,          {.v = dmenucmd } },
	{ MODKEY,               XK_r,                    spawn,          {.v = dmenucmd } },
	{ MODKEY,               XK_space,                spawn,          {.v = dmenucmd } },

	{ 0,                    XF86XK_AudioRaiseVolume, spawn,          {.v = volupcmd } },
	{ 0,                    XF86XK_AudioLowerVolume, spawn,          {.v = voldowncmd } },
	{ MODKEY,               XK_F12,                  spawn,          {.v = volupcmd } },
	{ MODKEY,               XK_F11,                  spawn,          {.v = voldowncmd } },

	{ Mod1Mask,             XK_p,                    spawn,          {.v = spotifytogglecmd } },
	{ Mod1Mask,             XK_bracketleft,          spawn,          {.v = spotifyprevcmd } },
	{ Mod1Mask,             XK_bracketright,         spawn,          {.v = spotifynextcmd } },

	{ Mod1Mask|ControlMask, XK_Delete,               spawn,          {.v = exitdmenucmd } },

	{ Mod4Mask,             XK_F2,                   spawn,          {.v = dmenucmd } },
	{ Mod4Mask,             XK_comma,                tagmon,         {.i = -1 } },
	{ Mod4Mask,             XK_period,               tagmon,         {.i = +1 } },
	{ Mod4Mask,             XK_space,                togglefloating, {0} },
	{ Mod4Mask,             XK_Return,               spawn,          {.v = termcmd } },

	{ Mod4Mask,             XK_l,                    spawn,          SHCMD("slock") },

	{ 0,                    XF86XK_Display,          spawn,          SHCMD("x1_eDP.sh") },

	TAGKEYS(XK_1, 0)
	TAGKEYS(XK_2, 1)
	TAGKEYS(XK_3, 2)
	TAGKEYS(XK_4, 3)
	TAGKEYS(XK_5, 4)
	TAGKEYS(XK_6, 5)
	TAGKEYS(XK_7, 6)
	TAGKEYS(XK_8, 7)
	TAGKEYS(XK_9, 8)
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        focusstack,     {.i = +1 } },
	{ ClkClientWin,         Mod4Mask,       Button1,        movemouse,      {0} },
	{ ClkClientWin,         Mod4Mask,       Button3,        resizemouse,    {0} },
	{ ClkClientWin,         Mod4Mask,       Button2,        killclient,     {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
	/* other */
	{ ClkStatusText,        0,              Button1,        spawn,          SHCMD("scratchpad") },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkStatusText,        0,              Button3,        spawn,          SHCMD("pavucontrol") },
	{ ClkStatusText,        0,              Button4,        spawn,          {.v = volupcmd } },
	{ ClkStatusText,        0,              Button5,        spawn,          {.v = voldowncmd } },
};
