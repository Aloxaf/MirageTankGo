#############################################################################
# Generated by PAGE version 4.10
# in conjunction with Tcl version 8.6
set vTcl(timestamp) ""


#############################################################################
## vTcl Code to Load User Images see vTcl:save2 in file.tcl

catch {package require Img}

foreach img {

        {{[file join / home zhonghua Coding Python MirageTank remu.png]} {user image} user {}}

            } {
# from vTcl:image:dump_create_image_footer
    eval set _file [lindex $img 0]
    vTcl:image:create_new_image\
        $_file [lindex $img 1] [lindex $img 2] [lindex $img 3]
}

if {!$vTcl(borrow)} {

set vTcl(actual_gui_bg) #d9d9d9
set vTcl(actual_gui_fg) #000000
set vTcl(actual_gui_menu_bg) #d9d9d9
set vTcl(actual_gui_menu_fg) #000000
set vTcl(complement_color) #d9d9d9
set vTcl(analog_color_p) #d9d9d9
set vTcl(analog_color_m) #d9d9d9
set vTcl(active_fg) #000000
set vTcl(actual_gui_menu_active_bg)  #d8d8d8
set vTcl(active_menu_fg) #000000
}

#################################
#LIBRARY PROCEDURES
#


if {[info exists vTcl(sourcing)]} {

proc vTcl:project:info {} {
    set base .top37
    namespace eval ::widgets::$base {
        set dflt,origin 0
        set runvisible 1
    }
    set site_4_0 .top37.tNo38.t0 
    set site_4_0 $site_4_0
    set site_4_1 .top37.tNo38.t1 
    set site_4_0 $site_4_1
    namespace eval ::widgets_bindings {
        set tagslist _TopLevel
    }
    namespace eval ::vTcl::modules::main {
        set procs {
        }
        set compounds {
        }
        set projectType single
    }
}
}

#################################
# GENERATED GUI PROCEDURES
#

proc vTclWindow.top37 {base} {
    if {$base == ""} {
        set base .top37
    }
    if {[winfo exists $base]} {
        wm deiconify $base; return
    }
    set top $base
    ###################
    # CREATING WIDGETS
    ###################
    vTcl::widgets::core::toplevel::createCmd $top -class Toplevel \
        -background {#d9d9d9} -highlightcolor black 
    wm withdraw $top
    wm focusmodel $top passive
    wm geometry $top 810x729+408+311
    update
    # set in toplevel.wgt.
    global vTcl
    global img_list
    set vTcl(save,dflt,origin) 0
    wm maxsize $top 1905 1050
    wm minsize $top 1 1
    wm overrideredirect $top 0
    wm resizable $top 0 0
    wm title $top "MirageTankGoGUI"
    vTcl:DefineAlias "$top" "Toplevel1" vTcl:Toplevel:WidgetProc "" 1
    entry $top.ent38 \
        -background white -font TkFixedFont -foreground {#000000} \
        -highlightcolor black -insertbackground black \
        -selectbackground {#c4c4c4} -selectforeground black \
        -textvariable defaultWhite 
    vTcl:DefineAlias "$top.ent38" "hostFile" vTcl:WidgetProc "Toplevel1" 1
    button $top.but41 \
        -activebackground {#d9d9d9} -activeforeground black \
        -background {#d9d9d9} -command hostFileBrowser -foreground {#000000} \
        -highlightcolor black -text 浏览.. 
    vTcl:DefineAlias "$top.but41" "hostBrowse" vTcl:WidgetProc "Toplevel1" 1
    label $top.lab42 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#d9d9d9} -foreground {#000000} -highlightcolor black \
        -text 白底图片: 
    vTcl:DefineAlias "$top.lab42" "Label1" vTcl:WidgetProc "Toplevel1" 1
    label $top.lab43 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#d9d9d9} -foreground {#000000} -highlightcolor black \
        -text {黑底图片: } 
    vTcl:DefineAlias "$top.lab43" "Label2" vTcl:WidgetProc "Toplevel1" 1
    entry $top.ent44 \
        -background white -font TkFixedFont -foreground {#000000} \
        -highlightcolor black -insertbackground black \
        -selectbackground {#c4c4c4} -selectforeground black \
        -textvariable defaultBlack 
    vTcl:DefineAlias "$top.ent44" "hideFile" vTcl:WidgetProc "Toplevel1" 1
    button $top.but45 \
        -activebackground {#d9d9d9} -activeforeground black \
        -background {#d9d9d9} -command hideFileBrowser -foreground {#000000} \
        -highlightcolor black -text 浏览.. 
    vTcl:DefineAlias "$top.but45" "hideBrowse" vTcl:WidgetProc "Toplevel1" 1
    entry $top.ent47 \
        -background white -font TkFixedFont -foreground {#000000} \
        -highlightcolor black -insertbackground black \
        -selectbackground {#c4c4c4} -selectforeground black \
        -textvariable defaultOutput 
    vTcl:DefineAlias "$top.ent47" "outputFile" vTcl:WidgetProc "Toplevel1" 1
    button $top.but48 \
        -activebackground {#d9d9d9} -activeforeground black \
        -background {#d9d9d9} -command outputFileBrowser \
        -foreground {#000000} -highlightcolor black -text 浏览.. 
    vTcl:DefineAlias "$top.but48" "outputBrowse" vTcl:WidgetProc "Toplevel1" 1
    label $top.lab49 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#d9d9d9} -foreground {#000000} -highlightcolor black \
        -text 输出文件: 
    vTcl:DefineAlias "$top.lab49" "Label3" vTcl:WidgetProc "Toplevel1" 1
    button $top.but53 \
        -activebackground {#d9d9d9} -activeforeground black \
        -background {#d9d9d9} -command startBuild -foreground {#000000} \
        -highlightcolor black -text 开始发车! 
    vTcl:DefineAlias "$top.but53" "start" vTcl:WidgetProc "Toplevel1" 1
    button $top.but61 \
        -activebackground {#d9d9d9} -activeforeground black \
        -background {#d9d9d9} -command tryBuild -foreground {#000000} \
        -highlightcolor black -text 试驾 
    vTcl:DefineAlias "$top.but61" "haveATry" vTcl:WidgetProc "Toplevel1" 1
    label $top.lab63 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#ffffff} -foreground {#000000} -highlightcolor black \
        -image [vTcl:image:get_image [file join / home zhonghua Coding Python MirageTank remu.png]] \
        -text 白底效果 
    vTcl:DefineAlias "$top.lab63" "showWhite" vTcl:WidgetProc "Toplevel1" 1
    label $top.lab64 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#000000} -foreground {#000000} -highlightcolor black \
        -image [vTcl:image:get_image [file join / home zhonghua Coding Python MirageTank remu.png]] \
        -text 黑底效果 
    vTcl:DefineAlias "$top.lab64" "showBlack" vTcl:WidgetProc "Toplevel1" 1
    ttk::style configure TNotebook -background #d9d9d9
    ttk::style configure TNotebook.Tab -background #d9d9d9
    ttk::style configure TNotebook.Tab -foreground #000000
    ttk::style configure TNotebook.Tab -font TkDefaultFont
    ttk::style map TNotebook.Tab -background [list disabled #d9d9d9 selected #d9d9d9]
    ttk::notebook $top.tNo38 \
        -width 342 -height 169 -takefocus {} 
    vTcl:DefineAlias "$top.tNo38" "TNotebook1" vTcl:WidgetProc "Toplevel1" 1
    frame $top.tNo38.t0 \
        -background {#d9d9d9} -highlightcolor black 
    vTcl:DefineAlias "$top.tNo38.t0" "TNotebook1_t0" vTcl:WidgetProc "Toplevel1" 1
    $top.tNo38 add $top.tNo38.t0 \
        -padding 0 -sticky nsew -state normal -text 灰度车 -image {} \
        -compound none -underline -1 
    set site_4_0  $top.tNo38.t0
    spinbox $site_4_0.spi47 \
        -activebackground {#f9f9f9} -background white -foreground black \
        -from 0.0 -highlightcolor black -increment 0.01 \
        -insertbackground black -justify right -selectbackground {#c4c4c4} \
        -selectforeground black -to 1.0 
    vTcl:DefineAlias "$site_4_0.spi47" "blackLight" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_0.lab49 \
        -background {#d9d9d9} -foreground {#000000} -text 黑底亮度: 
    vTcl:DefineAlias "$site_4_0.lab49" "Label7" vTcl:WidgetProc "Toplevel1" 1
    checkbutton $site_4_0.che50 \
        -background {#d9d9d9} -foreground {#000000} -justify right \
        -state active -text 开启棋盘格 -variable che50 
    vTcl:DefineAlias "$site_4_0.che50" "enableChess" vTcl:WidgetProc "Toplevel1" 1
    place $site_4_0.spi47 \
        -in $site_4_0 -x 120 -y 60 -width 156 -height 26 -anchor nw \
        -bordermode inside 
    place $site_4_0.lab49 \
        -in $site_4_0 -x 40 -y 60 -anchor nw -bordermode ignore 
    place $site_4_0.che50 \
        -in $site_4_0 -x 30 -y 20 -anchor nw -bordermode ignore 
    frame $top.tNo38.t1 \
        -background {#d9d9d9} -highlightcolor black 
    vTcl:DefineAlias "$top.tNo38.t1" "TNotebook1_t1" vTcl:WidgetProc "Toplevel1" 1
    $top.tNo38 add $top.tNo38.t1 \
        -padding 0 -sticky nsew -state normal -text 彩色车 -image {} \
        -compound none -underline -1 
    set site_4_1  $top.tNo38.t1
    spinbox $site_4_1.spi41 \
        -activebackground {#f9f9f9} -background white -foreground black \
        -from 0.0 -highlightcolor black -increment 0.01 \
        -insertbackground black -justify right -selectbackground {#c4c4c4} \
        -selectforeground black -to 1.0 
    vTcl:DefineAlias "$site_4_1.spi41" "whiteColor" vTcl:WidgetProc "Toplevel1" 1
    spinbox $site_4_1.spi42 \
        -activebackground {#f9f9f9} -background white -foreground black \
        -from 0.0 -highlightcolor black -increment 0.01 \
        -insertbackground black -justify right -selectbackground {#c4c4c4} \
        -selectforeground black -to 1.0 
    vTcl:DefineAlias "$site_4_1.spi42" "blackColor" vTcl:WidgetProc "Toplevel1" 1
    spinbox $site_4_1.spi43 \
        -activebackground {#f9f9f9} -background white -foreground black \
        -from 0.0 -highlightcolor black -increment 0.01 \
        -insertbackground black -justify right -selectbackground {#c4c4c4} \
        -selectforeground black -to 1.0 
    vTcl:DefineAlias "$site_4_1.spi43" "blackLight_c" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_1.lab44 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#d9d9d9} -foreground {#000000} -highlightcolor black \
        -text 黑底亮度: 
    vTcl:DefineAlias "$site_4_1.lab44" "Label5" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_1.lab45 \
        -activebackground {#f9f9f9} -activeforeground black \
        -background {#d9d9d9} -foreground {#000000} -highlightcolor black \
        -text 白底色彩: 
    vTcl:DefineAlias "$site_4_1.lab45" "Label6" vTcl:WidgetProc "Toplevel1" 1
    label $site_4_1.lab48 \
        -background {#d9d9d9} -foreground {#000000} -text 黑底色彩: 
    vTcl:DefineAlias "$site_4_1.lab48" "Label4" vTcl:WidgetProc "Toplevel1" 1
    place $site_4_1.spi41 \
        -in $site_4_1 -x 120 -y 60 -width 156 -height 26 -anchor nw \
        -bordermode inside 
    place $site_4_1.spi42 \
        -in $site_4_1 -x 120 -y 100 -width 156 -height 26 -anchor nw \
        -bordermode inside 
    place $site_4_1.spi43 \
        -in $site_4_1 -x 120 -y 20 -width 156 -height 26 -anchor nw \
        -bordermode inside 
    place $site_4_1.lab44 \
        -in $site_4_1 -x 40 -y 20 -width 68 -height 24 -anchor nw \
        -bordermode inside 
    place $site_4_1.lab45 \
        -in $site_4_1 -x 40 -y 60 -width 68 -height 24 -anchor nw \
        -bordermode inside 
    place $site_4_1.lab48 \
        -in $site_4_1 -x 40 -y 100 -width 68 -relwidth 0 -height 24 \
        -relheight 0 -anchor nw -bordermode ignore 
    ###################
    # SETTING GEOMETRY
    ###################
    place $top.ent38 \
        -in $top -x 110 -y 30 -width 206 -relwidth 0 -height 26 -relheight 0 \
        -anchor nw -bordermode ignore 
    place $top.but41 \
        -in $top -x 330 -y 30 -width 72 -relwidth 0 -height 26 -relheight 0 \
        -anchor nw -bordermode ignore 
    place $top.lab42 \
        -in $top -x 30 -y 30 -anchor nw -bordermode ignore 
    place $top.lab43 \
        -in $top -x 30 -y 60 -anchor nw -bordermode ignore 
    place $top.ent44 \
        -in $top -x 110 -y 60 -width 206 -relwidth 0 -height 26 -relheight 0 \
        -anchor nw -bordermode ignore 
    place $top.but45 \
        -in $top -x 330 -y 60 -width 72 -relwidth 0 -height 26 -relheight 0 \
        -anchor nw -bordermode ignore 
    place $top.ent47 \
        -in $top -x 110 -y 90 -width 206 -relwidth 0 -height 26 -relheight 0 \
        -anchor nw -bordermode ignore 
    place $top.but48 \
        -in $top -x 330 -y 90 -width 72 -relwidth 0 -height 26 -relheight 0 \
        -anchor nw -bordermode ignore 
    place $top.lab49 \
        -in $top -x 30 -y 90 -anchor nw -bordermode ignore 
    place $top.but53 \
        -in $top -x 240 -y 150 -width 132 -relwidth 0 -height 42 -relheight 0 \
        -anchor nw -bordermode ignore 
    place $top.but61 \
        -in $top -x 60 -y 150 -width 132 -relwidth 0 -height 42 -relheight 0 \
        -anchor nw -bordermode ignore 
    place $top.lab63 \
        -in $top -x 40 -y 220 -width 340 -relwidth 0 -height 484 -relheight 0 \
        -anchor nw -bordermode ignore 
    place $top.lab64 \
        -in $top -x 430 -y 220 -width 340 -relwidth 0 -height 484 \
        -relheight 0 -anchor nw -bordermode ignore 
    place $top.tNo38 \
        -in $top -x 430 -y 30 -width 342 -relwidth 0 -height 169 -relheight 0 \
        -anchor nw -bordermode ignore 

    vTcl:FireEvent $base <<Ready>>
}

#############################################################################
## Binding tag:  _TopLevel

bind "_TopLevel" <<Create>> {
    if {![info exists _topcount]} {set _topcount 0}; incr _topcount
}
bind "_TopLevel" <<DeleteWindow>> {
    if {[set ::%W::_modal]} {
                vTcl:Toplevel:WidgetProc %W endmodal
            } else {
                destroy %W; if {$_topcount == 0} {exit}
            }
}
bind "_TopLevel" <Destroy> {
    if {[winfo toplevel %W] == "%W"} {incr _topcount -1}
}

  set btop ""
if {$vTcl(borrow)} {
    set btop .bor[expr int([expr rand() * 100])]
    while {[lsearch $btop $vTcl(tops)] != -1} {
        set btop .bor[expr int([expr rand() * 100])]
    }
}
Window show .
Window show .top37 $btop
if {$vTcl(borrow)} {
    $btop configure -background plum
}

