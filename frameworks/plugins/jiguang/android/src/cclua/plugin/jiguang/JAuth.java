package cclua.plugin.jiguang;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.graphics.Color;
import android.graphics.Point;
import android.graphics.Typeface;
import android.util.Log;
import android.view.Display;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import cclua.AppContext;
import cclua.LuaJ;
import cclua.PluginManager;
import cn.jiguang.verifysdk.api.JVerificationInterface;
import cn.jiguang.verifysdk.api.JVerifyUIConfig;
import cn.jiguang.verifysdk.api.LoginSettings;
import cn.jiguang.verifysdk.api.PreLoginListener;
import cn.jiguang.verifysdk.api.RequestCallback;
import cn.jiguang.verifysdk.api.VerifyListener;

@SuppressWarnings("unused")
public class JAuth {
    private static final String TAG = JAuth.class.getSimpleName();
    private static Application mContext;
    private static int mWinHeight;
    private static int mWinWidth;

    static {
        PluginManager.registerPlugin(new PluginManager.Handler() {
            @Override
            public void onInit(Application app) {
                Log.i(TAG, "init jauth");
                mContext = app;
            }

            @Override
            public void onStart(Activity context) {
                Display defaultDisplay = context.getWindowManager().getDefaultDisplay();
                Point point = new Point();
                defaultDisplay.getSize(point);
                if (point.x > point.y) {
                    mWinHeight = point.x;
                    mWinWidth = point.y;
                } else {
                    mWinHeight = point.y;
                    mWinWidth = point.x;
                }
            }
        });
    }

    public static void init(String appKey, String channel) {
        JVerificationInterface.init(mContext, new RequestCallback<String>() {
            @Override
            public void onResult(int code, String msg) {
                Log.d(TAG, "init JAuth: code = " + code + " msg = " + msg);
            }
        });
    }

    public static void setDebug(boolean debug) {
        JVerificationInterface.setDebugMode(debug);
    }

    public static boolean isInitSuccess() {
        return JVerificationInterface.isInitSuccess();
    }

    public static boolean checkVerifyEnable() {
        return JVerificationInterface.checkVerifyEnable(mContext);
    }

    public static void getToken(int timeout, final int handler) {
        JVerificationInterface.getToken(mContext, timeout, new VerifyListener() {
            @Override
            public void onResult(int code, String content, String operator) {
                try {
                    JSONObject data = new JSONObject();
                    data.put("code", code);
                    if (code == 2000) {
                        data.put("success", true);
                        data.put("token", content);
                        data.put("operator", operator);
                    } else {
                        data.put("content", content);
                    }
                    LuaJ.invokeOnce(handler, data.toString());
                } catch (Exception e) {
                    e.printStackTrace();
                    LuaJ.invokeOnce(handler, "{\"code\":-1}");
                }
            }
        });
    }

    public static void preLogin(int timeout, final int handler) {
        JVerificationInterface.preLogin(mContext, timeout, new PreLoginListener() {
            @Override
            public void onResult(int code, String content) {
                try {
                    JSONObject data = new JSONObject();
                    data.put("code", code);
                    data.put("success", code == 7000);
                    data.put("content", content);
                    LuaJ.invokeOnce(handler, data.toString());
                } catch (Exception e) {
                    e.printStackTrace();
                    LuaJ.invokeOnce(handler, "{\"code\":-1}");
                }
            }
        });
    }

    public static void clearPreLoginCache() {
        JVerificationInterface.clearPreLoginCache();
    }

    public static void loginAuth(int timeout, final int handler) {
        LoginSettings settings = new LoginSettings();
        settings.setTimeout(timeout);
        settings.setAutoFinish(true);
        JVerificationInterface.loginAuth(mContext, settings, new VerifyListener() {
            @Override
            public void onResult(int code, String content, String operator) {
                try {
                    JSONObject data = new JSONObject();
                    data.put("code", code);
                    if (code == 6000) {
                        data.put("success", true);
                        data.put("token", content);
                        data.put("operator", operator);
                    } else {
                        data.put("content", content);
                    }
                    LuaJ.invokeOnce(handler, data.toString());
                } catch (Exception e) {
                    e.printStackTrace();
                    LuaJ.invokeOnce(handler, "{\"code\":-1}");
                }
            }
        });
    }

    public static void dismissLoginAuth(boolean needCloseAnim) {
        JVerificationInterface.dismissLoginAuthActivity(needCloseAnim, new RequestCallback<String>() {
            @Override
            public void onResult(int code, String desc) {
                Log.d(TAG, "dismissLoginAuth: code = " + code + " desc = " + desc);
            }
        });
    }

    public static void getSmsCode(String phonenum, String signid, String tempid, final int handler) {
        JVerificationInterface.getSmsCode(mContext, phonenum, signid, tempid, new RequestCallback<String>() {
            @Override
            public void onResult(int code, String msg) {
                try {
                    JSONObject data = new JSONObject();
                    data.put("code", code);
                    data.put("success", code == 3000);
                    data.put("content", msg);
                    LuaJ.invokeOnce(handler, data.toString());
                } catch (Exception e) {
                    e.printStackTrace();
                    LuaJ.invokeOnce(handler, "{\"code\":-1}");
                }
            }
        });
    }

    public static void setSmsIntervalTime(long intervalTime) {
        JVerificationInterface.setSmsIntervalTime(intervalTime);
    }

    public static void configUI(String dataStr, boolean landscape) {
        try {
            JSONObject data = new JSONObject(dataStr);
            JVerifyUIConfig.Builder builder;
            if (data.has("dialogTheme")) {
                builder = landscape ? getDialogLandscapeConfig() : getDialogPortraitConfig();
            } else {
                builder = landscape ? getFullScreenLandscapeConfig() : getFullScreenPortraitConfig();
            }
            if (data.has("authBGImgPath")) {
                builder.setAuthBGImgPath(data.getString("authBGImgPath"));
            }
            if (data.has("authBGGifPath")) {
                builder.setAuthBGGifPath(data.getString("authBGGifPath"));
            }
            if (data.has("authBGVideoPath")) {
                builder.setAuthBGVideoPath(data.getString("authBGVideoPath"), null);
            }
            if (data.has("statusBarColorWithNav")) {
                builder.setStatusBarColorWithNav(data.getBoolean("statusBarColorWithNav"));
            }
            if (data.has("statusBarDarkMode")) {
                builder.setStatusBarDarkMode(data.getBoolean("statusBarDarkMode"));
            }
            if (data.has("statusBarTransparent")) {
                builder.setStatusBarTransparent(data.getBoolean("statusBarTransparent"));
            }
            if (data.has("statusBarHidden")) {
                builder.setStatusBarHidden(data.getBoolean("statusBarHidden"));
            }
            if (data.has("virtualButtonTransparent")) {
                builder.setVirtualButtonTransparent(data.getBoolean("virtualButtonTransparent"));
            }
            if (data.has("navColor")) {
                builder.setNavColor(data.getInt("navColor"));
            }
            if (data.has("navText")) {
                builder.setNavText(data.getString("navText"));
            }
            if (data.has("navTextColor")) {
                builder.setNavTextColor(data.getInt("navTextColor"));
            }
            if (data.has("navReturnImgPath")) {
                builder.setNavReturnImgPath(data.getString("navReturnImgPath"));
            }
            if (data.has("navTransparent")) {
                builder.setNavTransparent(data.getBoolean("navTransparent"));
            }
            if (data.has("navTextSize")) {
                builder.setNavTextSize(data.getInt("navTextSize"));
            }
            if (data.has("navReturnBtnHidden")) {
                builder.setNavReturnBtnHidden(data.getBoolean("navReturnBtnHidden"));
            }
            if (data.has("navReturnBtnWidth")) {
                builder.setNavReturnBtnWidth(data.getInt("navReturnBtnWidth"));
            }
            if (data.has("navReturnBtnHeight")) {
                builder.setNavReturnBtnHeight(data.getInt("navReturnBtnHeight"));
            }
            if (data.has("navReturnBtnOffsetX")) {
                builder.setNavReturnBtnOffsetX(data.getInt("navReturnBtnOffsetX"));
            }
            if (data.has("navReturnBtnRightOffsetX")) {
                builder.setNavReturnBtnRightOffsetX(data.getInt("navReturnBtnRightOffsetX"));
            }
            if (data.has("navReturnBtnOffsetY")) {
                builder.setNavReturnBtnOffsetY(data.getInt("navReturnBtnOffsetY"));
            }
            if (data.has("navHidden")) {
                builder.setNavHidden(data.getBoolean("navHidden"));
            }
            if (data.has("navTextBold")) {
                builder.setNavTextBold(data.getBoolean("navTextBold"));
            }
            if (data.has("logoWidth")) {
                builder.setLogoWidth(data.getInt("logoWidth"));
            }
            if (data.has("logoHeight")) {
                builder.setLogoHeight(data.getInt("logoHeight"));
            }
            if (data.has("logoOffsetY")) {
                builder.setLogoOffsetY(data.getInt("logoOffsetY"));
            }
            if (data.has("logoOffsetX")) {
                builder.setLogoOffsetX(data.getInt("logoOffsetX"));
            }
            if (data.has("logoOffsetBottomY")) {
                builder.setLogoOffsetBottomY(data.getInt("logoOffsetBottomY"));
            }
            if (data.has("logoHidden")) {
                builder.setLogoHidden(data.getBoolean("logoHidden"));
            }
            if (data.has("logoImgPath")) {
                builder.setLogoImgPath(data.getString("logoImgPath"));
            }
            if (data.has("numberColor")) {
                builder.setNumberColor(data.getInt("numberColor"));
            }
            if (data.has("numFieldOffsetY")) {
                builder.setNumFieldOffsetY(data.getInt("numFieldOffsetY"));
            }
            if (data.has("numFieldOffsetX")) {
                builder.setNumFieldOffsetX(data.getInt("numFieldOffsetX"));
            }
            if (data.has("numberFieldOffsetBottomY")) {
                builder.setNumberFieldOffsetBottomY(data.getInt("numberFieldOffsetBottomY"));
            }
            if (data.has("numberFieldWidth")) {
                builder.setNumberFieldWidth(data.getInt("numberFieldWidth"));
            }
            if (data.has("numberFieldHeight")) {
                builder.setNumberFieldHeight(data.getInt("numberFieldHeight"));
            }
            if (data.has("numberTextBold")) {
                builder.setNumberTextBold(data.getBoolean("numberTextBold"));
            }
            if (data.has("numberSize")) {
                builder.setNumberSize(data.getDouble("numberSize"));
            }
            if (data.has("logBtnText")) {
                builder.setLogBtnText(data.getString("logBtnText"));
            }
            if (data.has("logBtnImgPath")) {
                builder.setLogBtnImgPath(data.getString("logBtnImgPath"));
            }
            if (data.has("logBtnTextColor")) {
                builder.setLogBtnTextColor(data.getInt("logBtnTextColor"));
            }
            if (data.has("logBtnOffsetY")) {
                builder.setLogBtnOffsetY(data.getInt("logBtnOffsetY"));
            }
            if (data.has("logBtnOffsetX")) {
                builder.setLogBtnOffsetX(data.getInt("logBtnOffsetX"));
            }
            if (data.has("logBtnWidth")) {
                builder.setLogBtnWidth(data.getInt("logBtnWidth"));
            }
            if (data.has("logBtnHeight")) {
                builder.setLogBtnHeight(data.getInt("logBtnHeight"));
            }
            if (data.has("logBtnTextSize")) {
                builder.setLogBtnTextSize(data.getInt("logBtnTextSize"));
            }
            if (data.has("logBtnBottomOffsetY")) {
                builder.setLogBtnBottomOffsetY(data.getInt("logBtnBottomOffsetY"));
            }
            if (data.has("logBtnTextBold")) {
                builder.setLogBtnTextBold(data.getBoolean("logBtnTextBold"));
            }

            if (data.has("appPrivacyOne")) {
                JSONArray arr = data.getJSONArray("appPrivacyOne");
                builder.setAppPrivacyOne(arr.getString(0), arr.getString(1));
            }
            if (data.has("appPrivacyTwo")) {
                JSONArray arr = data.getJSONArray("appPrivacyTwo");
                builder.setAppPrivacyTwo(arr.getString(0), arr.getString(1));
            }
            if (data.has("appPrivacyColor")) {
                JSONArray arr = data.getJSONArray("appPrivacyColor");
                builder.setAppPrivacyColor(arr.getInt(0), arr.getInt(1));
            }
            if (data.has("privacyText")) {
                JSONArray arr = data.getJSONArray("privacyText");
                builder.setPrivacyText(arr.getString(0), arr.getString(1),
                        arr.getString(2), arr.getString(3));
            }
            if (data.has("checkedImgPath")) {
                builder.setCheckedImgPath(data.getString("checkedImgPath"));
            }
            if (data.has("uncheckedImgPath")) {
                builder.setUncheckedImgPath(data.getString("uncheckedImgPath"));
            }
            if (data.has("privacyOffsetY")) {
                builder.setPrivacyOffsetY(data.getInt("privacyOffsetY"));
            }
            if (data.has("privacyOffsetX")) {
                builder.setPrivacyOffsetX(data.getInt("privacyOffsetX"));
            }
            if (data.has("privacyTextSize")) {
                builder.setPrivacyTextSize(data.getInt("privacyTextSize"));
            }
            if (data.has("privacyTopOffsetY")) {
                builder.setPrivacyTopOffsetY(data.getInt("privacyTopOffsetY"));
            }
            if (data.has("privacyCheckboxSize")) {
                builder.setPrivacyCheckboxSize(data.getInt("privacyCheckboxSize"));
            }
            if (data.has("privacyTextWidth")) {
                builder.setPrivacyTextWidth(data.getInt("privacyTextWidth"));
            }
            if (data.has("privacyState")) {
                builder.setPrivacyState(data.getBoolean("privacyState"));
            }
            if (data.has("privacyTextCenterGravity")) {
                builder.setPrivacyTextCenterGravity(data.getBoolean("privacyTextCenterGravity"));
            }
            if (data.has("privacyCheckboxHidden")) {
                builder.setPrivacyCheckboxHidden(data.getBoolean("privacyCheckboxHidden"));
            }
            if (data.has("privacyWithBookTitleMark")) {
                builder.setPrivacyWithBookTitleMark(data.getBoolean("privacyWithBookTitleMark"));
            }
            if (data.has("privacyCheckboxInCenter")) {
                builder.setPrivacyCheckboxInCenter(data.getBoolean("privacyCheckboxInCenter"));
            }
            if (data.has("privacyTextBold")) {
                builder.setPrivacyTextBold(data.getBoolean("privacyTextBold"));
            }
            if (data.has("privacyUnderlineText")) {
                builder.setPrivacyUnderlineText(data.getBoolean("privacyUnderlineText"));
            }

            if (data.has("privacyNavColor")) {
                builder.setPrivacyNavColor(data.getInt("privacyNavColor"));
            }
            if (data.has("privacyNavTitleTextColor")) {
                builder.setPrivacyNavTitleTextColor(data.getInt("privacyNavTitleTextColor"));
            }
            if (data.has("privacyNavTitleTextSize")) {
                builder.setPrivacyNavTitleTextSize(data.getInt("privacyNavTitleTextSize"));
            }

            if (data.has("appPrivacyNavTitle1")) {
                builder.setAppPrivacyNavTitle1(data.getString("appPrivacyNavTitle1"));
            }
            if (data.has("appPrivacyNavTitle2")) {
                builder.setAppPrivacyNavTitle2(data.getString("appPrivacyNavTitle2"));
            }

            if (data.has("privacyStatusBarColorWithNav")) {
                builder.setPrivacyStatusBarColorWithNav(data.getBoolean("privacyStatusBarColorWithNav"));
            }
            if (data.has("privacyStatusBarDarkMode")) {
                builder.setPrivacyStatusBarDarkMode(data.getBoolean("privacyStatusBarDarkMode"));
            }
            if (data.has("privacyStatusBarTransparent")) {
                builder.setPrivacyStatusBarTransparent(data.getBoolean("privacyStatusBarTransparent"));
            }
            if (data.has("privacyStatusBarHidden")) {
                builder.setPrivacyStatusBarHidden(data.getBoolean("privacyStatusBarHidden"));
            }
            if (data.has("privacyVirtualButtonTransparent")) {
                builder.setPrivacyVirtualButtonTransparent(data.getBoolean("privacyVirtualButtonTransparent"));
            }
            if (data.has("privacyNavTitleTextBold")) {
                builder.setPrivacyNavTitleTextBold(data.getBoolean("privacyNavTitleTextBold"));
            }

            if (data.has("sloganTextColor")) {
                builder.setSloganTextColor(data.getInt("sloganTextColor"));
            }
            if (data.has("sloganOffsetY")) {
                builder.setSloganOffsetY(data.getInt("sloganOffsetY"));
            }
            if (data.has("sloganOffsetX")) {
                builder.setSloganOffsetX(data.getInt("sloganOffsetX"));
            }
            if (data.has("sloganBottomOffsetY")) {
                builder.setSloganBottomOffsetY(data.getInt("sloganBottomOffsetY"));
            }
            if (data.has("sloganTextSize")) {
                builder.setSloganTextSize(data.getInt("sloganTextSize"));
            }
            if (data.has("sloganHidden")) {
                builder.setSloganHidden(data.getBoolean("sloganHidden"));
            }
            if (data.has("sloganTextBold")) {
                builder.setSloganTextBold(data.getBoolean("sloganTextBold"));
            }

            if (data.has("needStartAnim")) {
                builder.setNeedStartAnim(data.getBoolean("needStartAnim"));
            }
            if (data.has("needCloseAnim")) {
                builder.setNeedCloseAnim(data.getBoolean("needCloseAnim"));
            }
            if (data.has("dialogTheme")) {
                JSONArray arr = data.getJSONArray("dialogTheme");
                builder.setDialogTheme(arr.getInt(0), arr.getInt(1), arr.getInt(2),
                        arr.getInt(3), arr.getBoolean(4));

                ImageButton btnClose = new ImageButton(mContext);
                btnClose.setBackgroundColor(0x00000000);
                btnClose.setImageResource(getResID(builder.build().getNavReturnImgPath()));
                RelativeLayout.LayoutParams layout = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
                if (data.has("navReturnMargins")) {
                    JSONArray margins = data.getJSONArray("navReturnMargins");
                    layout.setMargins(margins.getInt(0), margins.getInt(1), margins.getInt(2),
                            margins.getInt(3));
                } else {
                    layout.setMargins(10, 10, 0, 0);
                }
                btnClose.setLayoutParams(layout);
                builder.addCustomView(btnClose, true, null);
            }
            JVerificationInterface.setCustomUIWithConfig(builder.build());
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    private static int getResID(final String resName) {
        return mContext.getResources().getIdentifier(resName, "drawable", mContext.getApplicationInfo().packageName);
    }

    private static int dp2Pix(Context context, float dp) {
        try {
            float density = context.getResources().getDisplayMetrics().density;
            return (int) (dp * density + 0.5F);
        } catch (Exception e) {
            return (int) dp;
        }
    }

    private static int px2dip(Context context, int pxValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (pxValue / scale + 0.5f);
    }

    private static JVerifyUIConfig.Builder getFullScreenLandscapeConfig() {
        AppContext context = (AppContext) AppContext.getContext();
        JVerifyUIConfig.Builder builder = new JVerifyUIConfig.Builder();
        builder.setStatusBarHidden(true);
        builder.setSloganTextColor(0xFFD0D0D9);
        builder.setSloganOffsetY(145);
        builder.setLogoOffsetY(20);
        builder.setNumFieldOffsetY(110);
        builder.setPrivacyState(true);
        builder.setLogoImgPath("ic_icon");
        builder.setNavTransparent(true);
        builder.setNavReturnImgPath("btn_back");
        builder.setCheckedImgPath("cb_chosen");
        builder.setUncheckedImgPath("cb_unchosen");
        builder.setNumberColor(0xFF222328);
        builder.setLogBtnImgPath("selector_btn_normal");
        builder.setLogBtnTextColor(0xFFFFFFFF);
        builder.setLogBtnText("一键登录");
        builder.setLogBtnOffsetY(175);
        builder.setLogBtnWidth(300);
        builder.setLogBtnHeight(45);
        builder.setAppPrivacyColor(0xFFBBBCC5, 0xFF8998FF);
        builder.setPrivacyText("登录即同意《", "", "", "》并授权此APP获取本机号码");
        builder.setPrivacyCheckboxHidden(true);
        builder.setPrivacyTextCenterGravity(true);
        builder.setPrivacyTextSize(12);
        // builder.setPrivacyOffsetX(52-15);
        builder.setPrivacyOffsetY(18);

        return builder;
    }

    private static JVerifyUIConfig.Builder getFullScreenPortraitConfig() {
        AppContext context = (AppContext) AppContext.getContext();
        JVerifyUIConfig.Builder builder = new JVerifyUIConfig.Builder();
        builder.setSloganTextColor(0xFFD0D0D9);
        builder.setLogoOffsetY(103);
        builder.setNumFieldOffsetY(190);
        builder.setPrivacyState(true);
        builder.setLogoImgPath("ic_icon");
        builder.setNavTransparent(true);
        builder.setNavReturnImgPath("btn_back");
        builder.setCheckedImgPath(null);
        builder.setNumberColor(0xFF222328);
        builder.setLogBtnImgPath("selector_btn_normal");
        builder.setLogBtnTextColor(0xFFFFFFFF);
        builder.setLogBtnText("一键登录");
        builder.setLogBtnOffsetY(255);
        builder.setLogBtnWidth(300);
        builder.setLogBtnHeight(45);
        builder.setAppPrivacyColor(0xFFBBBCC5, 0xFF8998FF);
        // builder.setPrivacyTopOffsetY(310);
        builder.setPrivacyText("登录即同意《", "", "", "》并授权此APP获取本机号码");
        builder.setPrivacyCheckboxHidden(true);
        builder.setPrivacyTextCenterGravity(true);
        builder.setPrivacyTextSize(12);
        //  builder.setPrivacyOffsetX(52-15);

        return builder;
    }

    private static JVerifyUIConfig.Builder getDialogPortraitConfig() {
        AppContext context = (AppContext) AppContext.getContext();
        int widthDp = px2dip(context, mWinWidth);
        JVerifyUIConfig.Builder builder = new JVerifyUIConfig.Builder().setDialogTheme(widthDp - 60, 300, 0, 0, false);
//        uiConfigBuilder.setLogoHeight(30);
//        uiConfigBuilder.setLogoWidth(30);
//        uiConfigBuilder.setLogoOffsetY(-15);
//        uiConfigBuilder.setLogoOffsetX((widthDp-40)/2-15-20);
//        uiConfigBuilder.setLogoImgPath("logo_login_land");
        builder.setLogoHidden(true);

        builder.setNumFieldOffsetY(104).setNumberColor(Color.BLACK);
        builder.setSloganOffsetY(135);
        builder.setSloganTextColor(0xFFD0D0D9);
        builder.setLogBtnOffsetY(161);

        builder.setPrivacyOffsetY(15);
        builder.setCheckedImgPath("cb_chosen");
        builder.setUncheckedImgPath("cb_unchosen");
        builder.setNumberColor(0xFF222328);
        builder.setLogBtnImgPath("selector_btn_normal");
        builder.setPrivacyState(true);
        builder.setLogBtnText("一键登录");
        builder.setLogBtnHeight(44);
        builder.setLogBtnWidth(250);
        builder.setAppPrivacyColor(0xFFBBBCC5, 0xFF8998FF);
        builder.setPrivacyText("登录即同意《", "", "", "》并授权此APP获取本机号码");
        builder.setPrivacyCheckboxHidden(true);
        builder.setPrivacyTextCenterGravity(true);
//        uiConfigBuilder.setPrivacyOffsetX(52-15);
        builder.setPrivacyTextSize(10);


        // 图标和标题
        LinearLayout layoutTitle = new LinearLayout(context);
        RelativeLayout.LayoutParams layoutTitleParam = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        layoutTitleParam.setMargins(0, dp2Pix(context, 50), 0, 0);
        layoutTitleParam.addRule(RelativeLayout.ALIGN_PARENT_TOP, RelativeLayout.TRUE);
        layoutTitleParam.addRule(RelativeLayout.CENTER_HORIZONTAL, RelativeLayout.TRUE);
        layoutTitleParam.setLayoutDirection(LinearLayout.HORIZONTAL);
        layoutTitle.setLayoutParams(layoutTitleParam);

        ImageView img = new ImageView(context);
        img.setImageResource(R.drawable.logo_login_land);
        TextView tvTitle = new TextView(context);
        tvTitle.setText("APP认证");
        tvTitle.setTextSize(19);
        tvTitle.setTextColor(Color.BLACK);
        tvTitle.setTypeface(Typeface.defaultFromStyle(Typeface.BOLD));

        LinearLayout.LayoutParams imgParam = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        imgParam.setMargins(0, 0, dp2Pix(context, 6), 0);
        LinearLayout.LayoutParams titleParam = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        imgParam.setMargins(0, 0, dp2Pix(context, 4), 0);
        layoutTitle.addView(img, imgParam);
        layoutTitle.addView(tvTitle, titleParam);
        builder.addCustomView(layoutTitle, false, null);

        // 关闭按钮
        ImageView closeButton = new ImageView(context);

        RelativeLayout.LayoutParams mLayoutParams1 = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        mLayoutParams1.setMargins(0, dp2Pix(context, 10.0f), dp2Pix(context, 10), 0);
        mLayoutParams1.addRule(RelativeLayout.ALIGN_PARENT_RIGHT, RelativeLayout.TRUE);
        mLayoutParams1.addRule(RelativeLayout.ALIGN_PARENT_TOP, RelativeLayout.TRUE);
        closeButton.setLayoutParams(mLayoutParams1);
        closeButton.setImageResource(R.drawable.btn_close);
        builder.addCustomView(closeButton, true, null);

        return builder;
    }

    private static JVerifyUIConfig.Builder getDialogLandscapeConfig() {
        AppContext context = (AppContext) AppContext.getContext();
        int widthDp = px2dip(context, mWinWidth);
        JVerifyUIConfig.Builder builder = new JVerifyUIConfig.Builder().setDialogTheme(480, widthDp - 100, 0, 0, false);
//        uiConfigBuilder.setLogoHeight(40);
//        uiConfigBuilder.setLogoWidth(40);
//        uiConfigBuilder.setLogoOffsetY(-15);
//        uiConfigBuilder.setLogoImgPath("logo_login_land");
        builder.setLogoHidden(true);

        builder.setNumFieldOffsetY(104).setNumberColor(Color.BLACK);
        builder.setNumberSize(22);
        builder.setSloganOffsetY(135);
        builder.setSloganTextColor(0xFFD0D0D9);
        builder.setLogBtnOffsetY(161);

        builder.setPrivacyOffsetY(15);
        builder.setCheckedImgPath("cb_chosen");
        builder.setUncheckedImgPath("cb_unchosen");
        builder.setNumberColor(0xFF222328);
        builder.setLogBtnImgPath("selector_btn_normal");
        builder.setPrivacyState(true);
        builder.setLogBtnText("一键登录");
        builder.setLogBtnHeight(44);
        builder.setLogBtnWidth(250);
        builder.setAppPrivacyColor(0xFFBBBCC5, 0xFF8998FF);
        builder.setPrivacyText("登录即同意《", "", "", "》并授权此APP获取本机号码");
        builder.setPrivacyCheckboxHidden(true);
        builder.setPrivacyTextCenterGravity(true);
//        uiConfigBuilder.setPrivacyOffsetX(52-15);
        builder.setPrivacyTextSize(10);

        // 图标和标题
        LinearLayout layoutTitle = new LinearLayout(context);
        RelativeLayout.LayoutParams layoutTitleParam = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        layoutTitleParam.setMargins(dp2Pix(context, 20), dp2Pix(context, 15), 0, 0);
        layoutTitleParam.addRule(RelativeLayout.ALIGN_PARENT_TOP, RelativeLayout.TRUE);
        layoutTitleParam.setLayoutDirection(LinearLayout.HORIZONTAL);
        layoutTitle.setLayoutParams(layoutTitleParam);

        ImageView img = new ImageView(context);
        img.setImageResource(R.drawable.logo_login_land);
        TextView tvTitle = new TextView(context);
        tvTitle.setText("APP认证");
        tvTitle.setTextSize(19);
        tvTitle.setTextColor(Color.BLACK);
        tvTitle.setTypeface(Typeface.defaultFromStyle(Typeface.BOLD));

        LinearLayout.LayoutParams imgParam = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        imgParam.setMargins(0, 0, dp2Pix(context, 6), 0);
        LinearLayout.LayoutParams titleParam = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        imgParam.setMargins(0, 0, dp2Pix(context, 4), 0);
        layoutTitle.addView(img, imgParam);
        layoutTitle.addView(tvTitle, titleParam);
        builder.addCustomView(layoutTitle, false, null);

        // 关闭按钮
        ImageView closeButton = new ImageView(context);

        RelativeLayout.LayoutParams mLayoutParams1 = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        mLayoutParams1.setMargins(0, dp2Pix(context, 10.0f), dp2Pix(context, 10), 0);
        mLayoutParams1.addRule(RelativeLayout.ALIGN_PARENT_RIGHT, RelativeLayout.TRUE);
        mLayoutParams1.addRule(RelativeLayout.ALIGN_PARENT_TOP, RelativeLayout.TRUE);
        closeButton.setLayoutParams(mLayoutParams1);
        closeButton.setImageResource(R.drawable.btn_close);
        builder.addCustomView(closeButton, true, null);

        return builder;
    }
}
