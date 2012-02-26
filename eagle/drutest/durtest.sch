<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="6.0">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="15" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="xilinx_spartan3_virtex4_and_5">
<packages>
<package name="TQ144">
<wire x1="-9.75" y1="9.4" x2="-9.75" y2="-9.4" width="0.1" layer="51"/>
<wire x1="-9.75" y1="-9.4" x2="-9.4" y2="-9.75" width="0.1" layer="51"/>
<wire x1="-9.4" y1="-9.75" x2="9.4" y2="-9.75" width="0.1" layer="51"/>
<wire x1="9.4" y1="-9.75" x2="9.75" y2="-9.4" width="0.1" layer="51"/>
<wire x1="9.75" y1="-9.4" x2="9.75" y2="9.4" width="0.1" layer="51"/>
<wire x1="9.75" y1="9.4" x2="9.4" y2="9.75" width="0.1" layer="51"/>
<wire x1="9.4" y1="9.75" x2="-9.4" y2="9.75" width="0.1" layer="51"/>
<wire x1="-9.4" y1="9.75" x2="-9.75" y2="9.4" width="0.1" layer="51"/>
<wire x1="-10" y1="9.5" x2="-10" y2="-9.5" width="0.2" layer="21"/>
<wire x1="-10" y1="-9.5" x2="-9.5" y2="-10" width="0.2" layer="21"/>
<wire x1="-9.5" y1="-10" x2="9.5" y2="-10" width="0.2" layer="21"/>
<wire x1="9.5" y1="-10" x2="10" y2="-9.5" width="0.2" layer="21"/>
<wire x1="10" y1="-9.5" x2="10" y2="9.5" width="0.2" layer="21"/>
<wire x1="10" y1="9.5" x2="9.5" y2="10" width="0.2" layer="21"/>
<wire x1="9.5" y1="10" x2="-9.5" y2="10" width="0.2" layer="21"/>
<wire x1="-9.5" y1="10" x2="-10" y2="9.5" width="0.2" layer="21"/>
<circle x="-9" y="9" radius="0.5" width="0.1" layer="21"/>
<smd name="P1" x="-10.7" y="8.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P2" x="-10.7" y="8.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P3" x="-10.7" y="7.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P4" x="-10.7" y="7.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P5" x="-10.7" y="6.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P6" x="-10.7" y="6.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P7" x="-10.7" y="5.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P8" x="-10.7" y="5.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P9" x="-10.7" y="4.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P10" x="-10.7" y="4.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P11" x="-10.7" y="3.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P12" x="-10.7" y="3.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P13" x="-10.7" y="2.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P14" x="-10.7" y="2.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P15" x="-10.7" y="1.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P16" x="-10.7" y="1.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P17" x="-10.7" y="0.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P18" x="-10.7" y="0.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P19" x="-10.7" y="-0.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P20" x="-10.7" y="-0.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P21" x="-10.7" y="-1.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P22" x="-10.7" y="-1.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P23" x="-10.7" y="-2.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P24" x="-10.7" y="-2.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P25" x="-10.7" y="-3.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P26" x="-10.7" y="-3.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P27" x="-10.7" y="-4.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P28" x="-10.7" y="-4.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P29" x="-10.7" y="-5.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P30" x="-10.7" y="-5.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P31" x="-10.7" y="-6.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P32" x="-10.7" y="-6.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P33" x="-10.7" y="-7.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P34" x="-10.7" y="-7.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P35" x="-10.7" y="-8.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P36" x="-10.7" y="-8.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P37" x="-8.75" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P38" x="-8.25" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P39" x="-7.75" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P40" x="-7.25" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P41" x="-6.75" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P42" x="-6.25" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P43" x="-5.75" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P44" x="-5.25" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P45" x="-4.75" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P46" x="-4.25" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P47" x="-3.75" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P48" x="-3.25" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P49" x="-2.75" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P50" x="-2.25" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P51" x="-1.75" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P52" x="-1.25" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P53" x="-0.75" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P54" x="-0.25" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P55" x="0.25" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P56" x="0.75" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P57" x="1.25" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P58" x="1.75" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P59" x="2.25" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P60" x="2.75" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P61" x="3.25" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P62" x="3.75" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P63" x="4.25" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P64" x="4.75" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P65" x="5.25" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P66" x="5.75" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P67" x="6.25" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P68" x="6.75" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P69" x="7.25" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P70" x="7.75" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P71" x="8.25" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P72" x="8.75" y="-10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P73" x="10.7" y="-8.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P74" x="10.7" y="-8.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P75" x="10.7" y="-7.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P76" x="10.7" y="-7.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P77" x="10.7" y="-6.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P78" x="10.7" y="-6.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P79" x="10.7" y="-5.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P80" x="10.7" y="-5.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P81" x="10.7" y="-4.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P82" x="10.7" y="-4.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P83" x="10.7" y="-3.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P84" x="10.7" y="-3.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P85" x="10.7" y="-2.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P86" x="10.7" y="-2.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P87" x="10.7" y="-1.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P88" x="10.7" y="-1.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P89" x="10.7" y="-0.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P90" x="10.7" y="-0.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P91" x="10.7" y="0.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P92" x="10.7" y="0.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P93" x="10.7" y="1.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P94" x="10.7" y="1.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P95" x="10.7" y="2.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P96" x="10.7" y="2.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P97" x="10.7" y="3.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P98" x="10.7" y="3.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P99" x="10.7" y="4.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P100" x="10.7" y="4.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P101" x="10.7" y="5.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P102" x="10.7" y="5.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P103" x="10.7" y="6.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P104" x="10.7" y="6.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P105" x="10.7" y="7.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P106" x="10.7" y="7.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P107" x="10.7" y="8.25" dx="1.6" dy="0.3" layer="1"/>
<smd name="P108" x="10.7" y="8.75" dx="1.6" dy="0.3" layer="1"/>
<smd name="P109" x="8.75" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P110" x="8.25" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P111" x="7.75" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P112" x="7.25" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P113" x="6.75" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P114" x="6.25" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P115" x="5.75" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P116" x="5.25" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P117" x="4.75" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P118" x="4.25" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P119" x="3.75" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P120" x="3.25" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P121" x="2.75" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P122" x="2.25" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P123" x="1.75" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P124" x="1.25" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P125" x="0.75" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P126" x="0.25" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P127" x="-0.25" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P128" x="-0.75" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P129" x="-1.25" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P130" x="-1.75" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P131" x="-2.25" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P132" x="-2.75" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P133" x="-3.25" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P134" x="-3.75" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P135" x="-4.25" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P136" x="-4.75" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P137" x="-5.25" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P138" x="-5.75" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P139" x="-6.25" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P140" x="-6.75" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P141" x="-7.25" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P142" x="-7.75" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P143" x="-8.25" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<smd name="P144" x="-8.75" y="10.7" dx="1.6" dy="0.3" layer="1" rot="R90"/>
<text x="-3.5" y="-3" size="1.27" layer="25">&gt;NAME</text>
<text x="-3.5" y="2" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-11" y1="8.6" x2="-10" y2="8.9" layer="51"/>
<rectangle x1="-11" y1="8.1" x2="-10" y2="8.4" layer="51"/>
<rectangle x1="-11" y1="7.6" x2="-10" y2="7.9" layer="51"/>
<rectangle x1="-11" y1="7.1" x2="-10" y2="7.4" layer="51"/>
<rectangle x1="-11" y1="6.6" x2="-10" y2="6.9" layer="51"/>
<rectangle x1="-11" y1="6.1" x2="-10" y2="6.4" layer="51"/>
<rectangle x1="-11" y1="5.6" x2="-10" y2="5.9" layer="51"/>
<rectangle x1="-11" y1="5.1" x2="-10" y2="5.4" layer="51"/>
<rectangle x1="-11" y1="4.6" x2="-10" y2="4.9" layer="51"/>
<rectangle x1="-11" y1="4.1" x2="-10" y2="4.4" layer="51"/>
<rectangle x1="-11" y1="3.6" x2="-10" y2="3.9" layer="51"/>
<rectangle x1="-11" y1="3.1" x2="-10" y2="3.4" layer="51"/>
<rectangle x1="-11" y1="2.6" x2="-10" y2="2.9" layer="51"/>
<rectangle x1="-11" y1="2.1" x2="-10" y2="2.4" layer="51"/>
<rectangle x1="-11" y1="1.6" x2="-10" y2="1.9" layer="51"/>
<rectangle x1="-11" y1="1.1" x2="-10" y2="1.4" layer="51"/>
<rectangle x1="-11" y1="0.6" x2="-10" y2="0.9" layer="51"/>
<rectangle x1="-11" y1="0.1" x2="-10" y2="0.4" layer="51"/>
<rectangle x1="-11" y1="-0.4" x2="-10" y2="-0.1" layer="51"/>
<rectangle x1="-11" y1="-0.9" x2="-10" y2="-0.6" layer="51"/>
<rectangle x1="-11" y1="-1.4" x2="-10" y2="-1.1" layer="51"/>
<rectangle x1="-11" y1="-1.9" x2="-10" y2="-1.6" layer="51"/>
<rectangle x1="-11" y1="-2.4" x2="-10" y2="-2.1" layer="51"/>
<rectangle x1="-11" y1="-2.9" x2="-10" y2="-2.6" layer="51"/>
<rectangle x1="-11" y1="-3.4" x2="-10" y2="-3.1" layer="51"/>
<rectangle x1="-11" y1="-3.9" x2="-10" y2="-3.6" layer="51"/>
<rectangle x1="-11" y1="-4.4" x2="-10" y2="-4.1" layer="51"/>
<rectangle x1="-11" y1="-4.9" x2="-10" y2="-4.6" layer="51"/>
<rectangle x1="-11" y1="-5.4" x2="-10" y2="-5.1" layer="51"/>
<rectangle x1="-11" y1="-5.9" x2="-10" y2="-5.6" layer="51"/>
<rectangle x1="-11" y1="-6.4" x2="-10" y2="-6.1" layer="51"/>
<rectangle x1="-11" y1="-6.9" x2="-10" y2="-6.6" layer="51"/>
<rectangle x1="-11" y1="-7.4" x2="-10" y2="-7.1" layer="51"/>
<rectangle x1="-11" y1="-7.9" x2="-10" y2="-7.6" layer="51"/>
<rectangle x1="-11" y1="-8.4" x2="-10" y2="-8.1" layer="51"/>
<rectangle x1="-11" y1="-8.9" x2="-10" y2="-8.6" layer="51"/>
<rectangle x1="-8.9" y1="-11" x2="-8.6" y2="-10" layer="51"/>
<rectangle x1="-8.4" y1="-11" x2="-8.1" y2="-10" layer="51"/>
<rectangle x1="-7.9" y1="-11" x2="-7.6" y2="-10" layer="51"/>
<rectangle x1="-7.4" y1="-11" x2="-7.1" y2="-10" layer="51"/>
<rectangle x1="-6.9" y1="-11" x2="-6.6" y2="-10" layer="51"/>
<rectangle x1="-6.4" y1="-11" x2="-6.1" y2="-10" layer="51"/>
<rectangle x1="-5.9" y1="-11" x2="-5.6" y2="-10" layer="51"/>
<rectangle x1="-5.4" y1="-11" x2="-5.1" y2="-10" layer="51"/>
<rectangle x1="-4.9" y1="-11" x2="-4.6" y2="-10" layer="51"/>
<rectangle x1="-4.4" y1="-11" x2="-4.1" y2="-10" layer="51"/>
<rectangle x1="-3.9" y1="-11" x2="-3.6" y2="-10" layer="51"/>
<rectangle x1="-3.4" y1="-11" x2="-3.1" y2="-10" layer="51"/>
<rectangle x1="-2.9" y1="-11" x2="-2.6" y2="-10" layer="51"/>
<rectangle x1="-2.4" y1="-11" x2="-2.1" y2="-10" layer="51"/>
<rectangle x1="-1.9" y1="-11" x2="-1.6" y2="-10" layer="51"/>
<rectangle x1="-1.4" y1="-11" x2="-1.1" y2="-10" layer="51"/>
<rectangle x1="-0.9" y1="-11" x2="-0.6" y2="-10" layer="51"/>
<rectangle x1="-0.4" y1="-11" x2="-0.1" y2="-10" layer="51"/>
<rectangle x1="0.1" y1="-11" x2="0.4" y2="-10" layer="51"/>
<rectangle x1="0.6" y1="-11" x2="0.9" y2="-10" layer="51"/>
<rectangle x1="1.1" y1="-11" x2="1.4" y2="-10" layer="51"/>
<rectangle x1="1.6" y1="-11" x2="1.9" y2="-10" layer="51"/>
<rectangle x1="2.1" y1="-11" x2="2.4" y2="-10" layer="51"/>
<rectangle x1="2.6" y1="-11" x2="2.9" y2="-10" layer="51"/>
<rectangle x1="3.1" y1="-11" x2="3.4" y2="-10" layer="51"/>
<rectangle x1="3.6" y1="-11" x2="3.9" y2="-10" layer="51"/>
<rectangle x1="4.1" y1="-11" x2="4.4" y2="-10" layer="51"/>
<rectangle x1="4.6" y1="-11" x2="4.9" y2="-10" layer="51"/>
<rectangle x1="5.1" y1="-11" x2="5.4" y2="-10" layer="51"/>
<rectangle x1="5.6" y1="-11" x2="5.9" y2="-10" layer="51"/>
<rectangle x1="6.1" y1="-11" x2="6.4" y2="-10" layer="51"/>
<rectangle x1="6.6" y1="-11" x2="6.9" y2="-10" layer="51"/>
<rectangle x1="7.1" y1="-11" x2="7.4" y2="-10" layer="51"/>
<rectangle x1="7.6" y1="-11" x2="7.9" y2="-10" layer="51"/>
<rectangle x1="8.1" y1="-11" x2="8.4" y2="-10" layer="51"/>
<rectangle x1="8.6" y1="-11" x2="8.9" y2="-10" layer="51"/>
<rectangle x1="10" y1="-8.9" x2="11" y2="-8.6" layer="51"/>
<rectangle x1="10" y1="-8.4" x2="11" y2="-8.1" layer="51"/>
<rectangle x1="10" y1="-7.9" x2="11" y2="-7.6" layer="51"/>
<rectangle x1="10" y1="-7.4" x2="11" y2="-7.1" layer="51"/>
<rectangle x1="10" y1="-6.9" x2="11" y2="-6.6" layer="51"/>
<rectangle x1="10" y1="-6.4" x2="11" y2="-6.1" layer="51"/>
<rectangle x1="10" y1="-5.9" x2="11" y2="-5.6" layer="51"/>
<rectangle x1="10" y1="-5.4" x2="11" y2="-5.1" layer="51"/>
<rectangle x1="10" y1="-4.9" x2="11" y2="-4.6" layer="51"/>
<rectangle x1="10" y1="-4.4" x2="11" y2="-4.1" layer="51"/>
<rectangle x1="10" y1="-3.9" x2="11" y2="-3.6" layer="51"/>
<rectangle x1="10" y1="-3.4" x2="11" y2="-3.1" layer="51"/>
<rectangle x1="10" y1="-2.9" x2="11" y2="-2.6" layer="51"/>
<rectangle x1="10" y1="-2.4" x2="11" y2="-2.1" layer="51"/>
<rectangle x1="10" y1="-1.9" x2="11" y2="-1.6" layer="51"/>
<rectangle x1="10" y1="-1.4" x2="11" y2="-1.1" layer="51"/>
<rectangle x1="10" y1="-0.9" x2="11" y2="-0.6" layer="51"/>
<rectangle x1="10" y1="-0.4" x2="11" y2="-0.1" layer="51"/>
<rectangle x1="10" y1="0.1" x2="11" y2="0.4" layer="51"/>
<rectangle x1="10" y1="0.6" x2="11" y2="0.9" layer="51"/>
<rectangle x1="10" y1="1.1" x2="11" y2="1.4" layer="51"/>
<rectangle x1="10" y1="1.6" x2="11" y2="1.9" layer="51"/>
<rectangle x1="10" y1="2.1" x2="11" y2="2.4" layer="51"/>
<rectangle x1="10" y1="2.6" x2="11" y2="2.9" layer="51"/>
<rectangle x1="10" y1="3.1" x2="11" y2="3.4" layer="51"/>
<rectangle x1="10" y1="3.6" x2="11" y2="3.9" layer="51"/>
<rectangle x1="10" y1="4.1" x2="11" y2="4.4" layer="51"/>
<rectangle x1="10" y1="4.6" x2="11" y2="4.9" layer="51"/>
<rectangle x1="10" y1="5.1" x2="11" y2="5.4" layer="51"/>
<rectangle x1="10" y1="5.6" x2="11" y2="5.9" layer="51"/>
<rectangle x1="10" y1="6.1" x2="11" y2="6.4" layer="51"/>
<rectangle x1="10" y1="6.6" x2="11" y2="6.9" layer="51"/>
<rectangle x1="10" y1="7.1" x2="11" y2="7.4" layer="51"/>
<rectangle x1="10" y1="7.6" x2="11" y2="7.9" layer="51"/>
<rectangle x1="10" y1="8.1" x2="11" y2="8.4" layer="51"/>
<rectangle x1="10" y1="8.6" x2="11" y2="8.9" layer="51"/>
<rectangle x1="8.6" y1="10" x2="8.9" y2="11" layer="51"/>
<rectangle x1="8.1" y1="10" x2="8.4" y2="11" layer="51"/>
<rectangle x1="7.6" y1="10" x2="7.9" y2="11" layer="51"/>
<rectangle x1="7.1" y1="10" x2="7.4" y2="11" layer="51"/>
<rectangle x1="6.6" y1="10" x2="6.9" y2="11" layer="51"/>
<rectangle x1="6.1" y1="10" x2="6.4" y2="11" layer="51"/>
<rectangle x1="5.6" y1="10" x2="5.9" y2="11" layer="51"/>
<rectangle x1="5.1" y1="10" x2="5.4" y2="11" layer="51"/>
<rectangle x1="4.6" y1="10" x2="4.9" y2="11" layer="51"/>
<rectangle x1="4.1" y1="10" x2="4.4" y2="11" layer="51"/>
<rectangle x1="3.6" y1="10" x2="3.9" y2="11" layer="51"/>
<rectangle x1="3.1" y1="10" x2="3.4" y2="11" layer="51"/>
<rectangle x1="2.6" y1="10" x2="2.9" y2="11" layer="51"/>
<rectangle x1="2.1" y1="10" x2="2.4" y2="11" layer="51"/>
<rectangle x1="1.6" y1="10" x2="1.9" y2="11" layer="51"/>
<rectangle x1="1.1" y1="10" x2="1.4" y2="11" layer="51"/>
<rectangle x1="0.6" y1="10" x2="0.9" y2="11" layer="51"/>
<rectangle x1="0.1" y1="10" x2="0.4" y2="11" layer="51"/>
<rectangle x1="-0.4" y1="10" x2="-0.1" y2="11" layer="51"/>
<rectangle x1="-0.9" y1="10" x2="-0.6" y2="11" layer="51"/>
<rectangle x1="-1.4" y1="10" x2="-1.1" y2="11" layer="51"/>
<rectangle x1="-1.9" y1="10" x2="-1.6" y2="11" layer="51"/>
<rectangle x1="-2.4" y1="10" x2="-2.1" y2="11" layer="51"/>
<rectangle x1="-2.9" y1="10" x2="-2.6" y2="11" layer="51"/>
<rectangle x1="-3.4" y1="10" x2="-3.1" y2="11" layer="51"/>
<rectangle x1="-3.9" y1="10" x2="-3.6" y2="11" layer="51"/>
<rectangle x1="-4.4" y1="10" x2="-4.1" y2="11" layer="51"/>
<rectangle x1="-4.9" y1="10" x2="-4.6" y2="11" layer="51"/>
<rectangle x1="-5.4" y1="10" x2="-5.1" y2="11" layer="51"/>
<rectangle x1="-5.9" y1="10" x2="-5.6" y2="11" layer="51"/>
<rectangle x1="-6.4" y1="10" x2="-6.1" y2="11" layer="51"/>
<rectangle x1="-6.9" y1="10" x2="-6.6" y2="11" layer="51"/>
<rectangle x1="-7.4" y1="10" x2="-7.1" y2="11" layer="51"/>
<rectangle x1="-7.9" y1="10" x2="-7.6" y2="11" layer="51"/>
<rectangle x1="-8.4" y1="10" x2="-8.1" y2="11" layer="51"/>
<rectangle x1="-8.9" y1="10" x2="-8.6" y2="11" layer="51"/>
</package>
</packages>
<symbols>
<symbol name="XC3S400TQ144_0">
<wire x1="-10.16" y1="12.7" x2="0" y2="12.7" width="0.254" layer="94"/>
<wire x1="0" y1="12.7" x2="0" y2="-15.24" width="0.254" layer="94"/>
<wire x1="0" y1="-15.24" x2="-10.16" y2="-15.24" width="0.254" layer="94"/>
<text x="-7.62" y="-17.78" size="1.778" layer="95">&gt;NAME</text>
<text x="-7.62" y="-20.32" size="1.778" layer="96">&gt;VALUE</text>
<pin name="IO_L01P_0VRN_0" x="5.08" y="10.16" length="middle" rot="R180"/>
<pin name="IO_L01N_0VRP_0" x="5.08" y="7.62" length="middle" rot="R180"/>
<pin name="IO_L27P_0" x="5.08" y="5.08" length="middle" rot="R180"/>
<pin name="IO_L27N_0" x="5.08" y="2.54" length="middle" rot="R180"/>
<pin name="IO_L30P_0" x="5.08" y="0" length="middle" rot="R180"/>
<pin name="IO_L30N_0" x="5.08" y="-2.54" length="middle" rot="R180"/>
<pin name="IO_L31N_0" x="5.08" y="-5.08" length="middle" rot="R180"/>
<pin name="IO_L31P_0VREF_0" x="5.08" y="-7.62" length="middle" rot="R180"/>
<pin name="IO_L32P_0GCLK6" x="5.08" y="-10.16" length="middle" rot="R180"/>
<pin name="IO_L32N_0GCLK7" x="5.08" y="-12.7" length="middle" rot="R180"/>
</symbol>
<symbol name="XC3S400TQ144_1">
<wire x1="-10.16" y1="12.7" x2="0" y2="12.7" width="0.254" layer="94"/>
<wire x1="0" y1="12.7" x2="0" y2="-12.7" width="0.254" layer="94"/>
<wire x1="0" y1="-12.7" x2="-10.16" y2="-12.7" width="0.254" layer="94"/>
<text x="-7.62" y="-15.24" size="1.778" layer="95">&gt;NAME</text>
<text x="-7.62" y="-17.78" size="1.778" layer="96">&gt;VALUE</text>
<pin name="IO" x="5.08" y="10.16" length="middle" rot="R180"/>
<pin name="IO_L01P_1VRN_1" x="5.08" y="7.62" length="middle" rot="R180"/>
<pin name="IO_L01N_1VRP_1" x="5.08" y="5.08" length="middle" rot="R180"/>
<pin name="IO_L28P_1" x="5.08" y="2.54" length="middle" rot="R180"/>
<pin name="IO_L28N_1" x="5.08" y="0" length="middle" rot="R180"/>
<pin name="IO_L31P_1" x="5.08" y="-2.54" length="middle" rot="R180"/>
<pin name="IO_L31N_1VREF_1" x="5.08" y="-5.08" length="middle" rot="R180"/>
<pin name="IO_L32P_1GCLK4" x="5.08" y="-7.62" length="middle" rot="R180"/>
<pin name="IO_L32N_1GCLK5" x="5.08" y="-10.16" length="middle" rot="R180"/>
</symbol>
<symbol name="XC3S400TQ144_0AND1">
<wire x1="-10.16" y1="5.08" x2="0" y2="5.08" width="0.254" layer="94"/>
<wire x1="0" y1="5.08" x2="0" y2="-5.08" width="0.254" layer="94"/>
<wire x1="0" y1="-5.08" x2="-10.16" y2="-5.08" width="0.254" layer="94"/>
<text x="-7.62" y="-7.62" size="1.778" layer="95">&gt;NAME</text>
<text x="-7.62" y="-10.16" size="1.778" layer="96">&gt;VALUE</text>
<pin name="VCCO_TOP0" x="5.08" y="2.54" length="middle" direction="pas" rot="R180"/>
<pin name="VCCO_TOP1" x="5.08" y="0" length="middle" direction="pas" rot="R180"/>
<pin name="VCCO_TOP2" x="5.08" y="-2.54" length="middle" direction="pas" rot="R180"/>
</symbol>
<symbol name="XC3S400TQ144_2">
<wire x1="-10.16" y1="17.78" x2="0" y2="17.78" width="0.254" layer="94"/>
<wire x1="0" y1="17.78" x2="0" y2="-20.32" width="0.254" layer="94"/>
<wire x1="0" y1="-20.32" x2="-10.16" y2="-20.32" width="0.254" layer="94"/>
<text x="-7.62" y="-22.86" size="1.778" layer="95">&gt;NAME</text>
<text x="-7.62" y="-25.4" size="1.778" layer="96">&gt;VALUE</text>
<pin name="IO_L01P_2VRN_2" x="5.08" y="15.24" length="middle" rot="R180"/>
<pin name="IO_L01N_2VRP_2" x="5.08" y="12.7" length="middle" rot="R180"/>
<pin name="IO_L20P_2" x="5.08" y="10.16" length="middle" rot="R180"/>
<pin name="IO_L20N_2" x="5.08" y="7.62" length="middle" rot="R180"/>
<pin name="IO_L21P_2" x="5.08" y="5.08" length="middle" rot="R180"/>
<pin name="IO_L21N_2" x="5.08" y="2.54" length="middle" rot="R180"/>
<pin name="IO_L22P_2" x="5.08" y="0" length="middle" rot="R180"/>
<pin name="IO_L22N_2" x="5.08" y="-2.54" length="middle" rot="R180"/>
<pin name="IO_L23P_2" x="5.08" y="-5.08" length="middle" rot="R180"/>
<pin name="IO_L24P_2" x="5.08" y="-7.62" length="middle" rot="R180"/>
<pin name="IO_L24N_2" x="5.08" y="-10.16" length="middle" rot="R180"/>
<pin name="IO_L40N_2" x="5.08" y="-12.7" length="middle" rot="R180"/>
<pin name="IO_L23N_2VREF_2" x="5.08" y="-15.24" length="middle" rot="R180"/>
<pin name="IO_L40P_2VREF_2" x="5.08" y="-17.78" length="middle" rot="R180"/>
</symbol>
<symbol name="XC3S400TQ144_3">
<wire x1="-10.16" y1="20.32" x2="0" y2="20.32" width="0.254" layer="94"/>
<wire x1="0" y1="20.32" x2="0" y2="-20.32" width="0.254" layer="94"/>
<wire x1="0" y1="-20.32" x2="-10.16" y2="-20.32" width="0.254" layer="94"/>
<text x="-7.62" y="-22.86" size="1.778" layer="95">&gt;NAME</text>
<text x="-7.62" y="-25.4" size="1.778" layer="96">&gt;VALUE</text>
<pin name="IO" x="5.08" y="17.78" length="middle" rot="R180"/>
<pin name="IO_L01P_3VRN_3" x="5.08" y="15.24" length="middle" rot="R180"/>
<pin name="IO_L01N_3VRP_3" x="5.08" y="12.7" length="middle" rot="R180"/>
<pin name="IO_L20P_3" x="5.08" y="10.16" length="middle" rot="R180"/>
<pin name="IO_L20N_3" x="5.08" y="7.62" length="middle" rot="R180"/>
<pin name="IO_L21P_3" x="5.08" y="5.08" length="middle" rot="R180"/>
<pin name="IO_L21N_3" x="5.08" y="2.54" length="middle" rot="R180"/>
<pin name="IO_L22P_3" x="5.08" y="0" length="middle" rot="R180"/>
<pin name="IO_L22N_3" x="5.08" y="-2.54" length="middle" rot="R180"/>
<pin name="IO_L23N_3" x="5.08" y="-5.08" length="middle" rot="R180"/>
<pin name="IO_L24P_3" x="5.08" y="-7.62" length="middle" rot="R180"/>
<pin name="IO_L24N_3" x="5.08" y="-10.16" length="middle" rot="R180"/>
<pin name="IO_L40P_3" x="5.08" y="-12.7" length="middle" rot="R180"/>
<pin name="IO_L23P_3VREF_3" x="5.08" y="-15.24" length="middle" rot="R180"/>
<pin name="IO_L40N_3VREF_3" x="5.08" y="-17.78" length="middle" rot="R180"/>
</symbol>
<symbol name="XC3S400TQ144_4">
<wire x1="-10.16" y1="15.24" x2="0" y2="15.24" width="0.254" layer="94"/>
<wire x1="0" y1="15.24" x2="0" y2="-15.24" width="0.254" layer="94"/>
<wire x1="0" y1="-15.24" x2="-10.16" y2="-15.24" width="0.254" layer="94"/>
<text x="-7.62" y="-17.78" size="1.778" layer="95">&gt;NAME</text>
<text x="-7.62" y="-20.32" size="1.778" layer="96">&gt;VALUE</text>
<pin name="IO_L01P_4VRN_4" x="5.08" y="12.7" length="middle" rot="R180"/>
<pin name="IO_L01N_4VRP_4" x="5.08" y="10.16" length="middle" rot="R180"/>
<pin name="IO_L31P_4DOUTBUSY" x="5.08" y="7.62" length="middle" rot="R180"/>
<pin name="IO_L31N_4INIT_B" x="5.08" y="5.08" length="middle" rot="R180"/>
<pin name="IO_L27N_4DIND0" x="5.08" y="2.54" length="middle" rot="R180"/>
<pin name="IO_L27P_4D1" x="5.08" y="0" length="middle" rot="R180"/>
<pin name="IO_L30N_4D2" x="5.08" y="-2.54" length="middle" rot="R180"/>
<pin name="IO_L30P_4D3" x="5.08" y="-5.08" length="middle" rot="R180"/>
<pin name="IO_L32P_4GCLK0" x="5.08" y="-7.62" length="middle" rot="R180"/>
<pin name="IO_L32N_4GCLK1" x="5.08" y="-10.16" length="middle" rot="R180"/>
<pin name="IOVREF_4" x="5.08" y="-12.7" length="middle" rot="R180"/>
</symbol>
<symbol name="XC3S400TQ144_5">
<wire x1="-10.16" y1="12.7" x2="0" y2="12.7" width="0.254" layer="94"/>
<wire x1="0" y1="12.7" x2="0" y2="-12.7" width="0.254" layer="94"/>
<wire x1="0" y1="-12.7" x2="-10.16" y2="-12.7" width="0.254" layer="94"/>
<text x="-7.62" y="-15.24" size="1.778" layer="95">&gt;NAME</text>
<text x="-7.62" y="-17.78" size="1.778" layer="96">&gt;VALUE</text>
<pin name="IO_L01P_5CS_B" x="5.08" y="10.16" length="middle" rot="R180"/>
<pin name="IO_L01N_5RDWR_B" x="5.08" y="7.62" length="middle" rot="R180"/>
<pin name="IO_L28N_5D6" x="5.08" y="5.08" length="middle" rot="R180"/>
<pin name="IO_L28P_5D7" x="5.08" y="2.54" length="middle" rot="R180"/>
<pin name="IO_L31N_5D4" x="5.08" y="0" length="middle" rot="R180"/>
<pin name="IO_L31P_5D5" x="5.08" y="-2.54" length="middle" rot="R180"/>
<pin name="IO_L32P_5GCLK2" x="5.08" y="-5.08" length="middle" rot="R180"/>
<pin name="IO_L32N_5GCLK3" x="5.08" y="-7.62" length="middle" rot="R180"/>
<pin name="IOVREF_5" x="5.08" y="-10.16" length="middle" rot="R180"/>
</symbol>
<symbol name="XC3S400TQ144_6">
<wire x1="-10.16" y1="17.78" x2="0" y2="17.78" width="0.254" layer="94"/>
<wire x1="0" y1="17.78" x2="0" y2="-20.32" width="0.254" layer="94"/>
<wire x1="0" y1="-20.32" x2="-10.16" y2="-20.32" width="0.254" layer="94"/>
<text x="-7.62" y="-22.86" size="1.778" layer="95">&gt;NAME</text>
<text x="-7.62" y="-25.4" size="1.778" layer="96">&gt;VALUE</text>
<pin name="IO_L01P_6VRN_6" x="5.08" y="15.24" length="middle" rot="R180"/>
<pin name="IO_L01N_6VRP_6" x="5.08" y="12.7" length="middle" rot="R180"/>
<pin name="IO_L20P_6" x="5.08" y="10.16" length="middle" rot="R180"/>
<pin name="IO_L20N_6" x="5.08" y="7.62" length="middle" rot="R180"/>
<pin name="IO_L21P_6" x="5.08" y="5.08" length="middle" rot="R180"/>
<pin name="IO_L21N_6" x="5.08" y="2.54" length="middle" rot="R180"/>
<pin name="IO_L22P_6" x="5.08" y="0" length="middle" rot="R180"/>
<pin name="IO_L22N_6" x="5.08" y="-2.54" length="middle" rot="R180"/>
<pin name="IO_L23P_6" x="5.08" y="-5.08" length="middle" rot="R180"/>
<pin name="IO_L23N_6" x="5.08" y="-7.62" length="middle" rot="R180"/>
<pin name="IO_L24P_6" x="5.08" y="-10.16" length="middle" rot="R180"/>
<pin name="IO_L40N_6" x="5.08" y="-12.7" length="middle" rot="R180"/>
<pin name="IO_L24N_6VREF_6" x="5.08" y="-15.24" length="middle" rot="R180"/>
<pin name="IO_L40P_6VREF_6" x="5.08" y="-17.78" length="middle" rot="R180"/>
</symbol>
<symbol name="XC3S400TQ144_7">
<wire x1="-10.16" y1="20.32" x2="0" y2="20.32" width="0.254" layer="94"/>
<wire x1="0" y1="20.32" x2="0" y2="-20.32" width="0.254" layer="94"/>
<wire x1="0" y1="-20.32" x2="-10.16" y2="-20.32" width="0.254" layer="94"/>
<text x="-7.62" y="-22.86" size="1.778" layer="95">&gt;NAME</text>
<text x="-7.62" y="-25.4" size="1.778" layer="96">&gt;VALUE</text>
<pin name="IO_L01P_7VRN_7" x="5.08" y="17.78" length="middle" rot="R180"/>
<pin name="IO_L01N_7VRP_7" x="5.08" y="15.24" length="middle" rot="R180"/>
<pin name="IO_L20P_7" x="5.08" y="12.7" length="middle" rot="R180"/>
<pin name="IO_L20N_7" x="5.08" y="10.16" length="middle" rot="R180"/>
<pin name="IO_L21P_7" x="5.08" y="7.62" length="middle" rot="R180"/>
<pin name="IO_L21N_7" x="5.08" y="5.08" length="middle" rot="R180"/>
<pin name="IO_L22P_7" x="5.08" y="2.54" length="middle" rot="R180"/>
<pin name="IO_L22N_7" x="5.08" y="0" length="middle" rot="R180"/>
<pin name="IO_L23P_7" x="5.08" y="-2.54" length="middle" rot="R180"/>
<pin name="IO_L23N_7" x="5.08" y="-5.08" length="middle" rot="R180"/>
<pin name="IO_L24P_7" x="5.08" y="-7.62" length="middle" rot="R180"/>
<pin name="IO_L24N_7" x="5.08" y="-10.16" length="middle" rot="R180"/>
<pin name="IO_L40P_7" x="5.08" y="-12.7" length="middle" rot="R180"/>
<pin name="IO_L40N_7VREF_7" x="5.08" y="-15.24" length="middle" rot="R180"/>
<pin name="IOVREF_7" x="5.08" y="-17.78" length="middle" rot="R180"/>
</symbol>
<symbol name="XC3S400TQ144_2AND3">
<wire x1="-10.16" y1="5.08" x2="0" y2="5.08" width="0.254" layer="94"/>
<wire x1="0" y1="5.08" x2="0" y2="-5.08" width="0.254" layer="94"/>
<wire x1="0" y1="-5.08" x2="-10.16" y2="-5.08" width="0.254" layer="94"/>
<text x="-7.62" y="-7.62" size="1.778" layer="95">&gt;NAME</text>
<text x="-7.62" y="-10.16" size="1.778" layer="96">&gt;VALUE</text>
<pin name="VCCO_RIGHT0" x="5.08" y="2.54" length="middle" direction="pas" rot="R180"/>
<pin name="VCCO_RIGHT1" x="5.08" y="0" length="middle" direction="pas" rot="R180"/>
<pin name="VCCO_RIGHT2" x="5.08" y="-2.54" length="middle" direction="pas" rot="R180"/>
</symbol>
<symbol name="XC3S400TQ144_4AND5">
<wire x1="-10.16" y1="5.08" x2="0" y2="5.08" width="0.254" layer="94"/>
<wire x1="0" y1="5.08" x2="0" y2="-5.08" width="0.254" layer="94"/>
<wire x1="0" y1="-5.08" x2="-10.16" y2="-5.08" width="0.254" layer="94"/>
<text x="-7.62" y="-7.62" size="1.778" layer="95">&gt;NAME</text>
<text x="-7.62" y="-10.16" size="1.778" layer="96">&gt;VALUE</text>
<pin name="VCCO_BOTTOM0" x="5.08" y="2.54" length="middle" direction="pas" rot="R180"/>
<pin name="VCCO_BOTTOM1" x="5.08" y="0" length="middle" direction="pas" rot="R180"/>
<pin name="VCCO_BOTTOM2" x="5.08" y="-2.54" length="middle" direction="pas" rot="R180"/>
</symbol>
<symbol name="XC3S400TQ144_6AND7">
<wire x1="-10.16" y1="5.08" x2="0" y2="5.08" width="0.254" layer="94"/>
<wire x1="0" y1="5.08" x2="0" y2="-5.08" width="0.254" layer="94"/>
<wire x1="0" y1="-5.08" x2="-10.16" y2="-5.08" width="0.254" layer="94"/>
<text x="-7.62" y="-7.62" size="1.778" layer="95">&gt;NAME</text>
<text x="-7.62" y="-10.16" size="1.778" layer="96">&gt;VALUE</text>
<pin name="VCCO_LEFT0" x="5.08" y="2.54" length="middle" direction="pas" rot="R180"/>
<pin name="VCCO_LEFT1" x="5.08" y="0" length="middle" direction="pas" rot="R180"/>
<pin name="VCCO_LEFT2" x="5.08" y="-2.54" length="middle" direction="pas" rot="R180"/>
</symbol>
<symbol name="XC3S400TQ144_GND">
<wire x1="-10.16" y1="20.32" x2="0" y2="20.32" width="0.254" layer="94"/>
<wire x1="0" y1="20.32" x2="0" y2="-22.86" width="0.254" layer="94"/>
<wire x1="0" y1="-22.86" x2="-10.16" y2="-22.86" width="0.254" layer="94"/>
<text x="-7.62" y="-25.4" size="1.778" layer="95">&gt;NAME</text>
<text x="-7.62" y="-27.94" size="1.778" layer="96">&gt;VALUE</text>
<pin name="GND0" x="5.08" y="17.78" length="middle" direction="pas" rot="R180"/>
<pin name="GND1" x="5.08" y="15.24" length="middle" direction="pas" rot="R180"/>
<pin name="GND2" x="5.08" y="12.7" length="middle" direction="pas" rot="R180"/>
<pin name="GND3" x="5.08" y="10.16" length="middle" direction="pas" rot="R180"/>
<pin name="GND4" x="5.08" y="7.62" length="middle" direction="pas" rot="R180"/>
<pin name="GND5" x="5.08" y="5.08" length="middle" direction="pas" rot="R180"/>
<pin name="GND6" x="5.08" y="2.54" length="middle" direction="pas" rot="R180"/>
<pin name="GND7" x="5.08" y="0" length="middle" direction="pas" rot="R180"/>
<pin name="GND8" x="5.08" y="-2.54" length="middle" direction="pas" rot="R180"/>
<pin name="GND9" x="5.08" y="-5.08" length="middle" direction="pas" rot="R180"/>
<pin name="GND10" x="5.08" y="-7.62" length="middle" direction="pas" rot="R180"/>
<pin name="GND11" x="5.08" y="-10.16" length="middle" direction="pas" rot="R180"/>
<pin name="GND12" x="5.08" y="-12.7" length="middle" direction="pas" rot="R180"/>
<pin name="GND13" x="5.08" y="-15.24" length="middle" direction="pas" rot="R180"/>
<pin name="GND14" x="5.08" y="-17.78" length="middle" direction="pas" rot="R180"/>
<pin name="GND15" x="5.08" y="-20.32" length="middle" direction="pas" rot="R180"/>
</symbol>
<symbol name="XC3S400TQ144_VCCAUX">
<wire x1="-10.16" y1="20.32" x2="0" y2="20.32" width="0.254" layer="94"/>
<wire x1="0" y1="20.32" x2="0" y2="-20.32" width="0.254" layer="94"/>
<wire x1="0" y1="-20.32" x2="-10.16" y2="-20.32" width="0.254" layer="94"/>
<text x="-7.62" y="-22.86" size="1.778" layer="95">&gt;NAME</text>
<text x="-7.62" y="-25.4" size="1.778" layer="96">&gt;VALUE</text>
<pin name="CCLK" x="5.08" y="17.78" length="middle" rot="R180"/>
<pin name="DONE" x="5.08" y="15.24" length="middle" rot="R180"/>
<pin name="HSWAP_EN" x="5.08" y="12.7" length="middle" rot="R180"/>
<pin name="M0" x="5.08" y="10.16" length="middle" rot="R180"/>
<pin name="M1" x="5.08" y="7.62" length="middle" rot="R180"/>
<pin name="M2" x="5.08" y="5.08" length="middle" rot="R180"/>
<pin name="PROG_B" x="5.08" y="2.54" length="middle" rot="R180"/>
<pin name="TCK" x="5.08" y="0" length="middle" rot="R180"/>
<pin name="TDI" x="5.08" y="-2.54" length="middle" rot="R180"/>
<pin name="TDO" x="5.08" y="-5.08" length="middle" rot="R180"/>
<pin name="TMS" x="5.08" y="-7.62" length="middle" rot="R180"/>
<pin name="VCCAUX0" x="5.08" y="-10.16" length="middle" direction="pas" rot="R180"/>
<pin name="VCCAUX1" x="5.08" y="-12.7" length="middle" direction="pas" rot="R180"/>
<pin name="VCCAUX2" x="5.08" y="-15.24" length="middle" direction="pas" rot="R180"/>
<pin name="VCCAUX3" x="5.08" y="-17.78" length="middle" direction="pas" rot="R180"/>
</symbol>
<symbol name="XC3S400TQ144_VCCINT">
<wire x1="-10.16" y1="5.08" x2="0" y2="5.08" width="0.254" layer="94"/>
<wire x1="0" y1="5.08" x2="0" y2="-7.62" width="0.254" layer="94"/>
<wire x1="0" y1="-7.62" x2="-10.16" y2="-7.62" width="0.254" layer="94"/>
<text x="-7.62" y="-10.16" size="1.778" layer="95">&gt;NAME</text>
<text x="-7.62" y="-12.7" size="1.778" layer="96">&gt;VALUE</text>
<pin name="VCCINT0" x="5.08" y="2.54" length="middle" direction="pas" rot="R180"/>
<pin name="VCCINT1" x="5.08" y="0" length="middle" direction="pas" rot="R180"/>
<pin name="VCCINT2" x="5.08" y="-2.54" length="middle" direction="pas" rot="R180"/>
<pin name="VCCINT3" x="5.08" y="-5.08" length="middle" direction="pas" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="XC3S400TQ144" prefix="U">
<description>Xilinx FPGA</description>
<gates>
<gate name="B0" symbol="XC3S400TQ144_0" x="0" y="0"/>
<gate name="B1" symbol="XC3S400TQ144_1" x="38.1" y="0"/>
<gate name="B0AND1" symbol="XC3S400TQ144_0AND1" x="76.2" y="0"/>
<gate name="B2" symbol="XC3S400TQ144_2" x="114.3" y="0"/>
<gate name="B3" symbol="XC3S400TQ144_3" x="152.4" y="0"/>
<gate name="B4" symbol="XC3S400TQ144_4" x="190.5" y="0"/>
<gate name="B5" symbol="XC3S400TQ144_5" x="228.6" y="0"/>
<gate name="B6" symbol="XC3S400TQ144_6" x="266.7" y="0"/>
<gate name="B7" symbol="XC3S400TQ144_7" x="304.8" y="0"/>
<gate name="B2AND3" symbol="XC3S400TQ144_2AND3" x="342.9" y="0"/>
<gate name="B4AND5" symbol="XC3S400TQ144_4AND5" x="381" y="0"/>
<gate name="B6AND7" symbol="XC3S400TQ144_6AND7" x="419.1" y="0"/>
<gate name="BGND" symbol="XC3S400TQ144_GND" x="457.2" y="0"/>
<gate name="BVCCAUX" symbol="XC3S400TQ144_VCCAUX" x="495.3" y="0"/>
<gate name="BVCCINT" symbol="XC3S400TQ144_VCCINT" x="533.4" y="0"/>
</gates>
<devices>
<device name="" package="TQ144">
<connects>
<connect gate="B0" pin="IO_L01N_0VRP_0" pad="P141"/>
<connect gate="B0" pin="IO_L01P_0VRN_0" pad="P140"/>
<connect gate="B0" pin="IO_L27N_0" pad="P137"/>
<connect gate="B0" pin="IO_L27P_0" pad="P135"/>
<connect gate="B0" pin="IO_L30N_0" pad="P132"/>
<connect gate="B0" pin="IO_L30P_0" pad="P131"/>
<connect gate="B0" pin="IO_L31N_0" pad="P130"/>
<connect gate="B0" pin="IO_L31P_0VREF_0" pad="P129"/>
<connect gate="B0" pin="IO_L32N_0GCLK7" pad="P128"/>
<connect gate="B0" pin="IO_L32P_0GCLK6" pad="P127"/>
<connect gate="B0AND1" pin="VCCO_TOP0" pad="P115"/>
<connect gate="B0AND1" pin="VCCO_TOP1" pad="P126"/>
<connect gate="B0AND1" pin="VCCO_TOP2" pad="P138"/>
<connect gate="B1" pin="IO" pad="P116"/>
<connect gate="B1" pin="IO_L01N_1VRP_1" pad="P113"/>
<connect gate="B1" pin="IO_L01P_1VRN_1" pad="P112"/>
<connect gate="B1" pin="IO_L28N_1" pad="P119"/>
<connect gate="B1" pin="IO_L28P_1" pad="P118"/>
<connect gate="B1" pin="IO_L31N_1VREF_1" pad="P123"/>
<connect gate="B1" pin="IO_L31P_1" pad="P122"/>
<connect gate="B1" pin="IO_L32N_1GCLK5" pad="P125"/>
<connect gate="B1" pin="IO_L32P_1GCLK4" pad="P124"/>
<connect gate="B2" pin="IO_L01N_2VRP_2" pad="P108"/>
<connect gate="B2" pin="IO_L01P_2VRN_2" pad="P107"/>
<connect gate="B2" pin="IO_L20N_2" pad="P105"/>
<connect gate="B2" pin="IO_L20P_2" pad="P104"/>
<connect gate="B2" pin="IO_L21N_2" pad="P103"/>
<connect gate="B2" pin="IO_L21P_2" pad="P102"/>
<connect gate="B2" pin="IO_L22N_2" pad="P100"/>
<connect gate="B2" pin="IO_L22P_2" pad="P99"/>
<connect gate="B2" pin="IO_L23N_2VREF_2" pad="P98"/>
<connect gate="B2" pin="IO_L23P_2" pad="P97"/>
<connect gate="B2" pin="IO_L24N_2" pad="P96"/>
<connect gate="B2" pin="IO_L24P_2" pad="P95"/>
<connect gate="B2" pin="IO_L40N_2" pad="P93"/>
<connect gate="B2" pin="IO_L40P_2VREF_2" pad="P92"/>
<connect gate="B2AND3" pin="VCCO_RIGHT0" pad="P75"/>
<connect gate="B2AND3" pin="VCCO_RIGHT1" pad="P91"/>
<connect gate="B2AND3" pin="VCCO_RIGHT2" pad="P106"/>
<connect gate="B3" pin="IO" pad="P76"/>
<connect gate="B3" pin="IO_L01N_3VRP_3" pad="P74"/>
<connect gate="B3" pin="IO_L01P_3VRN_3" pad="P73"/>
<connect gate="B3" pin="IO_L20N_3" pad="P78"/>
<connect gate="B3" pin="IO_L20P_3" pad="P77"/>
<connect gate="B3" pin="IO_L21N_3" pad="P80"/>
<connect gate="B3" pin="IO_L21P_3" pad="P79"/>
<connect gate="B3" pin="IO_L22N_3" pad="P83"/>
<connect gate="B3" pin="IO_L22P_3" pad="P82"/>
<connect gate="B3" pin="IO_L23N_3" pad="P85"/>
<connect gate="B3" pin="IO_L23P_3VREF_3" pad="P84"/>
<connect gate="B3" pin="IO_L24N_3" pad="P87"/>
<connect gate="B3" pin="IO_L24P_3" pad="P86"/>
<connect gate="B3" pin="IO_L40N_3VREF_3" pad="P90"/>
<connect gate="B3" pin="IO_L40P_3" pad="P89"/>
<connect gate="B4" pin="IOVREF_4" pad="P70"/>
<connect gate="B4" pin="IO_L01N_4VRP_4" pad="P69"/>
<connect gate="B4" pin="IO_L01P_4VRN_4" pad="P68"/>
<connect gate="B4" pin="IO_L27N_4DIND0" pad="P65"/>
<connect gate="B4" pin="IO_L27P_4D1" pad="P63"/>
<connect gate="B4" pin="IO_L30N_4D2" pad="P60"/>
<connect gate="B4" pin="IO_L30P_4D3" pad="P59"/>
<connect gate="B4" pin="IO_L31N_4INIT_B" pad="P58"/>
<connect gate="B4" pin="IO_L31P_4DOUTBUSY" pad="P57"/>
<connect gate="B4" pin="IO_L32N_4GCLK1" pad="P56"/>
<connect gate="B4" pin="IO_L32P_4GCLK0" pad="P55"/>
<connect gate="B4AND5" pin="VCCO_BOTTOM0" pad="P43"/>
<connect gate="B4AND5" pin="VCCO_BOTTOM1" pad="P54"/>
<connect gate="B4AND5" pin="VCCO_BOTTOM2" pad="P66"/>
<connect gate="B5" pin="IOVREF_5" pad="P44"/>
<connect gate="B5" pin="IO_L01N_5RDWR_B" pad="P41"/>
<connect gate="B5" pin="IO_L01P_5CS_B" pad="P40"/>
<connect gate="B5" pin="IO_L28N_5D6" pad="P47"/>
<connect gate="B5" pin="IO_L28P_5D7" pad="P46"/>
<connect gate="B5" pin="IO_L31N_5D4" pad="P51"/>
<connect gate="B5" pin="IO_L31P_5D5" pad="P50"/>
<connect gate="B5" pin="IO_L32N_5GCLK3" pad="P53"/>
<connect gate="B5" pin="IO_L32P_5GCLK2" pad="P52"/>
<connect gate="B6" pin="IO_L01N_6VRP_6" pad="P36"/>
<connect gate="B6" pin="IO_L01P_6VRN_6" pad="P35"/>
<connect gate="B6" pin="IO_L20N_6" pad="P33"/>
<connect gate="B6" pin="IO_L20P_6" pad="P32"/>
<connect gate="B6" pin="IO_L21N_6" pad="P31"/>
<connect gate="B6" pin="IO_L21P_6" pad="P30"/>
<connect gate="B6" pin="IO_L22N_6" pad="P28"/>
<connect gate="B6" pin="IO_L22P_6" pad="P27"/>
<connect gate="B6" pin="IO_L23N_6" pad="P26"/>
<connect gate="B6" pin="IO_L23P_6" pad="P25"/>
<connect gate="B6" pin="IO_L24N_6VREF_6" pad="P24"/>
<connect gate="B6" pin="IO_L24P_6" pad="P23"/>
<connect gate="B6" pin="IO_L40N_6" pad="P21"/>
<connect gate="B6" pin="IO_L40P_6VREF_6" pad="P20"/>
<connect gate="B6AND7" pin="VCCO_LEFT0" pad="P3"/>
<connect gate="B6AND7" pin="VCCO_LEFT1" pad="P19"/>
<connect gate="B6AND7" pin="VCCO_LEFT2" pad="P34"/>
<connect gate="B7" pin="IOVREF_7" pad="P4"/>
<connect gate="B7" pin="IO_L01N_7VRP_7" pad="P2"/>
<connect gate="B7" pin="IO_L01P_7VRN_7" pad="P1"/>
<connect gate="B7" pin="IO_L20N_7" pad="P6"/>
<connect gate="B7" pin="IO_L20P_7" pad="P5"/>
<connect gate="B7" pin="IO_L21N_7" pad="P8"/>
<connect gate="B7" pin="IO_L21P_7" pad="P7"/>
<connect gate="B7" pin="IO_L22N_7" pad="P11"/>
<connect gate="B7" pin="IO_L22P_7" pad="P10"/>
<connect gate="B7" pin="IO_L23N_7" pad="P13"/>
<connect gate="B7" pin="IO_L23P_7" pad="P12"/>
<connect gate="B7" pin="IO_L24N_7" pad="P15"/>
<connect gate="B7" pin="IO_L24P_7" pad="P14"/>
<connect gate="B7" pin="IO_L40N_7VREF_7" pad="P18"/>
<connect gate="B7" pin="IO_L40P_7" pad="P17"/>
<connect gate="BGND" pin="GND0" pad="P9"/>
<connect gate="BGND" pin="GND1" pad="P16"/>
<connect gate="BGND" pin="GND10" pad="P94"/>
<connect gate="BGND" pin="GND11" pad="P101"/>
<connect gate="BGND" pin="GND12" pad="P114"/>
<connect gate="BGND" pin="GND13" pad="P117"/>
<connect gate="BGND" pin="GND14" pad="P136"/>
<connect gate="BGND" pin="GND15" pad="P139"/>
<connect gate="BGND" pin="GND2" pad="P22"/>
<connect gate="BGND" pin="GND3" pad="P29"/>
<connect gate="BGND" pin="GND4" pad="P42"/>
<connect gate="BGND" pin="GND5" pad="P45"/>
<connect gate="BGND" pin="GND6" pad="P64"/>
<connect gate="BGND" pin="GND7" pad="P67"/>
<connect gate="BGND" pin="GND8" pad="P81"/>
<connect gate="BGND" pin="GND9" pad="P88"/>
<connect gate="BVCCAUX" pin="CCLK" pad="P72"/>
<connect gate="BVCCAUX" pin="DONE" pad="P71"/>
<connect gate="BVCCAUX" pin="HSWAP_EN" pad="P142"/>
<connect gate="BVCCAUX" pin="M0" pad="P38"/>
<connect gate="BVCCAUX" pin="M1" pad="P37"/>
<connect gate="BVCCAUX" pin="M2" pad="P39"/>
<connect gate="BVCCAUX" pin="PROG_B" pad="P143"/>
<connect gate="BVCCAUX" pin="TCK" pad="P110"/>
<connect gate="BVCCAUX" pin="TDI" pad="P144"/>
<connect gate="BVCCAUX" pin="TDO" pad="P109"/>
<connect gate="BVCCAUX" pin="TMS" pad="P111"/>
<connect gate="BVCCAUX" pin="VCCAUX0" pad="P48"/>
<connect gate="BVCCAUX" pin="VCCAUX1" pad="P62"/>
<connect gate="BVCCAUX" pin="VCCAUX2" pad="P120"/>
<connect gate="BVCCAUX" pin="VCCAUX3" pad="P134"/>
<connect gate="BVCCINT" pin="VCCINT0" pad="P49"/>
<connect gate="BVCCINT" pin="VCCINT1" pad="P61"/>
<connect gate="BVCCINT" pin="VCCINT2" pad="P121"/>
<connect gate="BVCCINT" pin="VCCINT3" pad="P133"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="cpcfpga">
<packages>
<package name="TSOP32">
<smd name="P9" x="-9.75" y="-0.25" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P10" x="-9.75" y="-0.75" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P11" x="-9.75" y="-1.25" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P12" x="-9.75" y="-1.75" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P13" x="-9.75" y="-2.25" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P14" x="-9.75" y="-2.75" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P15" x="-9.75" y="-3.25" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P16" x="-9.75" y="-3.75" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P8" x="-9.75" y="0.25" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P7" x="-9.75" y="0.75" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P6" x="-9.75" y="1.25" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P5" x="-9.75" y="1.75" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P4" x="-9.75" y="2.25" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P3" x="-9.75" y="2.75" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P2" x="-9.75" y="3.25" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P1" x="-9.75" y="3.75" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P24" x="10.25" y="-0.25" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P23" x="10.25" y="-0.75" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P22" x="10.25" y="-1.25" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P21" x="10.25" y="-1.75" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P20" x="10.25" y="-2.25" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P19" x="10.25" y="-2.75" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P18" x="10.25" y="-3.25" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P17" x="10.25" y="-3.75" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P25" x="10.25" y="0.25" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P26" x="10.25" y="0.75" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P27" x="10.25" y="1.25" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P28" x="10.25" y="1.75" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P29" x="10.25" y="2.25" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P30" x="10.25" y="2.75" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P31" x="10.25" y="3.25" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<smd name="P32" x="10.25" y="3.75" dx="0.2" dy="0.5" layer="1" rot="R270"/>
<circle x="-7.62" y="2.54" radius="1.27" width="0.127" layer="21"/>
<wire x1="-9.525" y1="4.445" x2="-9.525" y2="-4.445" width="0.127" layer="21"/>
<wire x1="-9.525" y1="-4.445" x2="10.16" y2="-4.445" width="0.127" layer="21"/>
<wire x1="10.16" y1="-4.445" x2="10.16" y2="4.445" width="0.127" layer="21"/>
<wire x1="10.16" y1="4.445" x2="-9.525" y2="4.445" width="0.127" layer="21"/>
</package>
</packages>
<symbols>
<symbol name="AS6C4008">
<pin name="A4" x="-27.94" y="-20.32" length="middle"/>
<pin name="A5" x="-27.94" y="-17.78" length="middle"/>
<pin name="A6" x="-27.94" y="-15.24" length="middle"/>
<pin name="A7" x="-27.94" y="-12.7" length="middle"/>
<pin name="A12" x="-27.94" y="-10.16" length="middle"/>
<pin name="A14" x="-27.94" y="-7.62" length="middle"/>
<pin name="A16" x="-27.94" y="-5.08" length="middle"/>
<pin name="A18" x="-27.94" y="-2.54" length="middle"/>
<pin name="VCC" x="-27.94" y="0" length="middle"/>
<pin name="A15" x="-27.94" y="2.54" length="middle"/>
<pin name="A17" x="-27.94" y="5.08" length="middle"/>
<pin name="WE" x="-27.94" y="7.62" length="middle"/>
<pin name="A13" x="-27.94" y="10.16" length="middle"/>
<pin name="A8" x="-27.94" y="12.7" length="middle"/>
<pin name="A9" x="-27.94" y="15.24" length="middle"/>
<pin name="A11" x="-27.94" y="17.78" length="middle"/>
<pin name="OE" x="27.94" y="17.78" length="middle" rot="R180"/>
<pin name="A10" x="27.94" y="15.24" length="middle" rot="R180"/>
<pin name="CE" x="27.94" y="12.7" length="middle" rot="R180"/>
<pin name="DQ7" x="27.94" y="10.16" length="middle" rot="R180"/>
<pin name="DQ6" x="27.94" y="7.62" length="middle" rot="R180"/>
<pin name="DQ5" x="27.94" y="5.08" length="middle" rot="R180"/>
<pin name="DQ4" x="27.94" y="2.54" length="middle" rot="R180"/>
<pin name="DQ3" x="27.94" y="0" length="middle" rot="R180"/>
<pin name="VSS" x="27.94" y="-2.54" length="middle" rot="R180"/>
<pin name="DQ2" x="27.94" y="-5.08" length="middle" rot="R180"/>
<pin name="DQ1" x="27.94" y="-7.62" length="middle" rot="R180"/>
<pin name="DQ0" x="27.94" y="-10.16" length="middle" rot="R180"/>
<pin name="A0" x="27.94" y="-12.7" length="middle" rot="R180"/>
<pin name="A1" x="27.94" y="-15.24" length="middle" rot="R180"/>
<pin name="A2" x="27.94" y="-17.78" length="middle" rot="R180"/>
<pin name="A3" x="27.94" y="-20.32" length="middle" rot="R180"/>
<wire x1="-22.86" y1="20.32" x2="22.86" y2="20.32" width="0.254" layer="97"/>
<wire x1="22.86" y1="20.32" x2="22.86" y2="-22.86" width="0.254" layer="97"/>
<wire x1="22.86" y1="-22.86" x2="-22.86" y2="-22.86" width="0.254" layer="97"/>
<wire x1="-22.86" y1="-22.86" x2="-22.86" y2="20.32" width="0.254" layer="97"/>
<text x="-5.08" y="5.08" size="1.27" layer="97">AS6C4008</text>
<text x="-5.08" y="2.54" size="1.27" layer="97">TSOP32</text>
<circle x="-12.7" y="12.7" radius="2.54" width="0.254" layer="94"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="AS6C4008">
<gates>
<gate name="G$1" symbol="AS6C4008" x="0" y="0"/>
</gates>
<devices>
<device name="" package="TSOP32">
<connects>
<connect gate="G$1" pin="A0" pad="P20"/>
<connect gate="G$1" pin="A1" pad="P19"/>
<connect gate="G$1" pin="A10" pad="P31"/>
<connect gate="G$1" pin="A11" pad="P1"/>
<connect gate="G$1" pin="A12" pad="P12"/>
<connect gate="G$1" pin="A13" pad="P4"/>
<connect gate="G$1" pin="A14" pad="P11"/>
<connect gate="G$1" pin="A15" pad="P7"/>
<connect gate="G$1" pin="A16" pad="P10"/>
<connect gate="G$1" pin="A17" pad="P6"/>
<connect gate="G$1" pin="A18" pad="P9"/>
<connect gate="G$1" pin="A2" pad="P18"/>
<connect gate="G$1" pin="A3" pad="P17"/>
<connect gate="G$1" pin="A4" pad="P16"/>
<connect gate="G$1" pin="A5" pad="P15"/>
<connect gate="G$1" pin="A6" pad="P14"/>
<connect gate="G$1" pin="A7" pad="P13"/>
<connect gate="G$1" pin="A8" pad="P3"/>
<connect gate="G$1" pin="A9" pad="P2"/>
<connect gate="G$1" pin="CE" pad="P30"/>
<connect gate="G$1" pin="DQ0" pad="P21"/>
<connect gate="G$1" pin="DQ1" pad="P22"/>
<connect gate="G$1" pin="DQ2" pad="P23"/>
<connect gate="G$1" pin="DQ3" pad="P25"/>
<connect gate="G$1" pin="DQ4" pad="P26"/>
<connect gate="G$1" pin="DQ5" pad="P27"/>
<connect gate="G$1" pin="DQ6" pad="P28"/>
<connect gate="G$1" pin="DQ7" pad="P29"/>
<connect gate="G$1" pin="OE" pad="P32"/>
<connect gate="G$1" pin="VCC" pad="P8"/>
<connect gate="G$1" pin="VSS" pad="P24"/>
<connect gate="G$1" pin="WE" pad="P5"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="U1" library="xilinx_spartan3_virtex4_and_5" deviceset="XC3S400TQ144" device=""/>
<part name="U$1" library="cpcfpga" deviceset="AS6C4008" device=""/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="U1" gate="B0" x="71.12" y="68.58" rot="R90"/>
<instance part="U1" gate="B1" x="106.68" y="68.58" rot="R90"/>
<instance part="U1" gate="B0AND1" x="-86.36" y="55.88"/>
<instance part="U1" gate="B2" x="134.62" y="40.64"/>
<instance part="U1" gate="B3" x="134.62" y="-5.08"/>
<instance part="U1" gate="B4" x="104.14" y="-35.56" rot="R270"/>
<instance part="U1" gate="B5" x="71.12" y="-35.56" rot="R270"/>
<instance part="U1" gate="B6" x="43.18" y="-7.62" rot="R180"/>
<instance part="U1" gate="B7" x="43.18" y="38.1" rot="R180"/>
<instance part="U1" gate="B2AND3" x="-86.36" y="38.1"/>
<instance part="U1" gate="B4AND5" x="-86.36" y="20.32"/>
<instance part="U1" gate="B6AND7" x="-86.36" y="2.54"/>
<instance part="U1" gate="BGND" x="-137.16" y="43.18"/>
<instance part="U1" gate="BVCCAUX" x="-137.16" y="-7.62"/>
<instance part="U1" gate="BVCCINT" x="-137.16" y="-38.1"/>
<instance part="U$1" gate="G$1" x="-12.7" y="17.78" rot="R90"/>
</instances>
<busses>
</busses>
<nets>
<net name="N$1" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L01P_7VRN_7"/>
<wire x1="38.1" y1="20.32" x2="7.62" y2="20.32" width="0.1524" layer="91"/>
<wire x1="7.62" y1="20.32" x2="7.62" y2="45.72" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="A3"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L01N_7VRP_7"/>
<pinref part="U$1" gate="G$1" pin="A2"/>
<wire x1="38.1" y1="22.86" x2="5.08" y2="22.86" width="0.1524" layer="91"/>
<wire x1="5.08" y1="22.86" x2="5.08" y2="45.72" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$3" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IOVREF_7"/>
<pinref part="U$1" gate="G$1" pin="A1"/>
<wire x1="38.1" y1="55.88" x2="2.54" y2="55.88" width="0.1524" layer="91"/>
<wire x1="2.54" y1="55.88" x2="2.54" y2="45.72" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L20P_7"/>
<pinref part="U$1" gate="G$1" pin="A0"/>
<wire x1="38.1" y1="25.4" x2="0" y2="25.4" width="0.1524" layer="91"/>
<wire x1="0" y1="25.4" x2="0" y2="45.72" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$5" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L20N_7"/>
<pinref part="U$1" gate="G$1" pin="DQ0"/>
<wire x1="38.1" y1="27.94" x2="-2.54" y2="27.94" width="0.1524" layer="91"/>
<wire x1="-2.54" y1="27.94" x2="-2.54" y2="45.72" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$6" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L21P_7"/>
<pinref part="U$1" gate="G$1" pin="DQ1"/>
<wire x1="38.1" y1="30.48" x2="-5.08" y2="30.48" width="0.1524" layer="91"/>
<wire x1="-5.08" y1="30.48" x2="-5.08" y2="45.72" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$7" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L21N_7"/>
<pinref part="U$1" gate="G$1" pin="DQ2"/>
<wire x1="38.1" y1="33.02" x2="-7.62" y2="33.02" width="0.1524" layer="91"/>
<wire x1="-7.62" y1="33.02" x2="-7.62" y2="45.72" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$8" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L22P_7"/>
<pinref part="U$1" gate="G$1" pin="DQ3"/>
<wire x1="38.1" y1="35.56" x2="-12.7" y2="35.56" width="0.1524" layer="91"/>
<wire x1="-12.7" y1="35.56" x2="-12.7" y2="45.72" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$9" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L22N_7"/>
<pinref part="U$1" gate="G$1" pin="DQ4"/>
<wire x1="38.1" y1="38.1" x2="-15.24" y2="38.1" width="0.1524" layer="91"/>
<wire x1="-15.24" y1="38.1" x2="-15.24" y2="45.72" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$10" class="0">
<segment>
<wire x1="40.64" y1="40.64" x2="35.56" y2="40.64" width="0.1524" layer="91"/>
<wire x1="35.56" y1="40.64" x2="35.56" y2="58.42" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="DQ5"/>
<wire x1="35.56" y1="58.42" x2="-17.78" y2="58.42" width="0.1524" layer="91"/>
<wire x1="-17.78" y1="58.42" x2="-17.78" y2="45.72" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$11" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L23N_7"/>
<wire x1="38.1" y1="43.18" x2="33.02" y2="43.18" width="0.1524" layer="91"/>
<wire x1="33.02" y1="43.18" x2="33.02" y2="60.96" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="DQ6"/>
<wire x1="33.02" y1="60.96" x2="-20.32" y2="60.96" width="0.1524" layer="91"/>
<wire x1="-20.32" y1="60.96" x2="-20.32" y2="45.72" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$12" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L24P_7"/>
<wire x1="38.1" y1="45.72" x2="30.48" y2="45.72" width="0.1524" layer="91"/>
<wire x1="30.48" y1="45.72" x2="30.48" y2="63.5" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="DQ7"/>
<wire x1="30.48" y1="63.5" x2="-22.86" y2="63.5" width="0.1524" layer="91"/>
<wire x1="-22.86" y1="63.5" x2="-22.86" y2="45.72" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$13" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L24N_7"/>
<wire x1="38.1" y1="48.26" x2="27.94" y2="48.26" width="0.1524" layer="91"/>
<wire x1="27.94" y1="48.26" x2="27.94" y2="66.04" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="A10"/>
<wire x1="27.94" y1="66.04" x2="-27.94" y2="66.04" width="0.1524" layer="91"/>
<wire x1="-27.94" y1="66.04" x2="-27.94" y2="45.72" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$14" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L40P_7"/>
<wire x1="38.1" y1="50.8" x2="25.4" y2="50.8" width="0.1524" layer="91"/>
<wire x1="25.4" y1="50.8" x2="25.4" y2="68.58" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="OE"/>
<wire x1="25.4" y1="68.58" x2="-30.48" y2="68.58" width="0.1524" layer="91"/>
<wire x1="-30.48" y1="68.58" x2="-30.48" y2="45.72" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$15" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L40N_7VREF_7"/>
<wire x1="38.1" y1="53.34" x2="-35.56" y2="53.34" width="0.1524" layer="91"/>
<wire x1="-35.56" y1="53.34" x2="-35.56" y2="-12.7" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="A11"/>
<wire x1="-35.56" y1="-12.7" x2="-30.48" y2="-12.7" width="0.1524" layer="91"/>
<wire x1="-30.48" y1="-12.7" x2="-30.48" y2="-10.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$16" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L40P_6VREF_6"/>
<pinref part="U$1" gate="G$1" pin="A9"/>
<wire x1="38.1" y1="10.16" x2="-27.94" y2="10.16" width="0.1524" layer="91"/>
<wire x1="-27.94" y1="10.16" x2="-27.94" y2="-10.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$17" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L40N_6"/>
<pinref part="U$1" gate="G$1" pin="A8"/>
<wire x1="38.1" y1="5.08" x2="-25.4" y2="5.08" width="0.1524" layer="91"/>
<wire x1="-25.4" y1="5.08" x2="-25.4" y2="-10.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$18" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L24P_6"/>
<pinref part="U$1" gate="G$1" pin="A13"/>
<wire x1="38.1" y1="2.54" x2="-22.86" y2="2.54" width="0.1524" layer="91"/>
<wire x1="-22.86" y1="2.54" x2="-22.86" y2="-10.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$19" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L24N_6VREF_6"/>
<pinref part="U$1" gate="G$1" pin="WE"/>
<wire x1="38.1" y1="7.62" x2="-20.32" y2="7.62" width="0.1524" layer="91"/>
<wire x1="-20.32" y1="7.62" x2="-20.32" y2="-10.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$20" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L23P_6"/>
<pinref part="U$1" gate="G$1" pin="A17"/>
<wire x1="38.1" y1="-2.54" x2="-17.78" y2="-2.54" width="0.1524" layer="91"/>
<wire x1="-17.78" y1="-2.54" x2="-17.78" y2="-10.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$21" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L23N_6"/>
<wire x1="38.1" y1="0" x2="35.56" y2="0" width="0.1524" layer="91"/>
<wire x1="35.56" y1="0" x2="35.56" y2="-40.64" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="A15"/>
<wire x1="35.56" y1="-40.64" x2="-15.24" y2="-40.64" width="0.1524" layer="91"/>
<wire x1="-15.24" y1="-40.64" x2="-15.24" y2="-10.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$22" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L22P_6"/>
<wire x1="38.1" y1="-7.62" x2="33.02" y2="-7.62" width="0.1524" layer="91"/>
<wire x1="33.02" y1="-7.62" x2="33.02" y2="-38.1" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="A18"/>
<wire x1="33.02" y1="-38.1" x2="-10.16" y2="-38.1" width="0.1524" layer="91"/>
<wire x1="-10.16" y1="-38.1" x2="-10.16" y2="-10.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$23" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L22N_6"/>
<wire x1="38.1" y1="-5.08" x2="30.48" y2="-5.08" width="0.1524" layer="91"/>
<wire x1="30.48" y1="-5.08" x2="30.48" y2="-35.56" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="A16"/>
<wire x1="30.48" y1="-35.56" x2="-7.62" y2="-35.56" width="0.1524" layer="91"/>
<wire x1="-7.62" y1="-35.56" x2="-7.62" y2="-10.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$24" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L21P_6"/>
<wire x1="38.1" y1="-12.7" x2="27.94" y2="-12.7" width="0.1524" layer="91"/>
<wire x1="27.94" y1="-12.7" x2="27.94" y2="-33.02" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="A14"/>
<wire x1="27.94" y1="-33.02" x2="-5.08" y2="-33.02" width="0.1524" layer="91"/>
<wire x1="-5.08" y1="-33.02" x2="-5.08" y2="-10.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$25" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L21N_6"/>
<wire x1="38.1" y1="-10.16" x2="25.4" y2="-10.16" width="0.1524" layer="91"/>
<wire x1="25.4" y1="-10.16" x2="25.4" y2="-30.48" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="A12"/>
<wire x1="25.4" y1="-30.48" x2="-2.54" y2="-30.48" width="0.1524" layer="91"/>
<wire x1="-2.54" y1="-30.48" x2="-2.54" y2="-10.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$26" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L20P_6"/>
<wire x1="38.1" y1="-17.78" x2="22.86" y2="-17.78" width="0.1524" layer="91"/>
<wire x1="22.86" y1="-17.78" x2="22.86" y2="-27.94" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="A7"/>
<wire x1="22.86" y1="-27.94" x2="0" y2="-27.94" width="0.1524" layer="91"/>
<wire x1="0" y1="-27.94" x2="0" y2="-10.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$27" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L20N_6"/>
<wire x1="38.1" y1="-15.24" x2="20.32" y2="-15.24" width="0.1524" layer="91"/>
<wire x1="20.32" y1="-15.24" x2="20.32" y2="-25.4" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="A6"/>
<wire x1="20.32" y1="-25.4" x2="2.54" y2="-25.4" width="0.1524" layer="91"/>
<wire x1="2.54" y1="-25.4" x2="2.54" y2="-10.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$28" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L01P_6VRN_6"/>
<pinref part="U$1" gate="G$1" pin="A5"/>
<wire x1="38.1" y1="-22.86" x2="5.08" y2="-22.86" width="0.1524" layer="91"/>
<wire x1="5.08" y1="-22.86" x2="5.08" y2="-10.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$29" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L01N_6VRP_6"/>
<pinref part="U$1" gate="G$1" pin="A4"/>
<wire x1="38.1" y1="-20.32" x2="7.62" y2="-20.32" width="0.1524" layer="91"/>
<wire x1="7.62" y1="-20.32" x2="7.62" y2="-10.16" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$30" class="0">
<segment>
<pinref part="U1" gate="B0AND1" pin="VCCO_TOP0"/>
<pinref part="U1" gate="B0AND1" pin="VCCO_TOP1"/>
<wire x1="-81.28" y1="58.42" x2="-81.28" y2="55.88" width="0.1524" layer="91"/>
<pinref part="U1" gate="B0AND1" pin="VCCO_TOP2"/>
<wire x1="-81.28" y1="55.88" x2="-81.28" y2="53.34" width="0.1524" layer="91"/>
<junction x="-81.28" y="55.88"/>
</segment>
</net>
<net name="N$31" class="0">
<segment>
<pinref part="U1" gate="B2AND3" pin="VCCO_RIGHT2"/>
<pinref part="U1" gate="B2AND3" pin="VCCO_RIGHT1"/>
<wire x1="-81.28" y1="35.56" x2="-81.28" y2="38.1" width="0.1524" layer="91"/>
<pinref part="U1" gate="B2AND3" pin="VCCO_RIGHT0"/>
<wire x1="-81.28" y1="38.1" x2="-81.28" y2="40.64" width="0.1524" layer="91"/>
<junction x="-81.28" y="38.1"/>
</segment>
</net>
<net name="N$32" class="0">
<segment>
<pinref part="U1" gate="B4AND5" pin="VCCO_BOTTOM2"/>
<pinref part="U1" gate="B4AND5" pin="VCCO_BOTTOM1"/>
<wire x1="-81.28" y1="17.78" x2="-81.28" y2="20.32" width="0.1524" layer="91"/>
<pinref part="U1" gate="B4AND5" pin="VCCO_BOTTOM0"/>
<wire x1="-81.28" y1="20.32" x2="-81.28" y2="22.86" width="0.1524" layer="91"/>
<junction x="-81.28" y="20.32"/>
</segment>
</net>
<net name="N$33" class="0">
<segment>
<pinref part="U1" gate="B6AND7" pin="VCCO_LEFT2"/>
<pinref part="U1" gate="B6AND7" pin="VCCO_LEFT1"/>
<wire x1="-81.28" y1="0" x2="-81.28" y2="2.54" width="0.1524" layer="91"/>
<pinref part="U1" gate="B6AND7" pin="VCCO_LEFT0"/>
<wire x1="-81.28" y1="2.54" x2="-81.28" y2="5.08" width="0.1524" layer="91"/>
<junction x="-81.28" y="2.54"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
</eagle>
