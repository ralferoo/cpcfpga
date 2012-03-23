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
<layer number="50" name="dxf" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="53" name="tGND_GNDA" color="7" fill="9" visible="no" active="no"/>
<layer number="54" name="bGND_GNDA" color="1" fill="9" visible="no" active="no"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
<layer number="250" name="Descript" color="3" fill="1" visible="no" active="no"/>
<layer number="251" name="SMDround" color="4" fill="9" visible="no" active="yes"/>
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
<library name="supply2">
<description>&lt;b&gt;Supply Symbols&lt;/b&gt;&lt;p&gt;
GND, VCC, 0V, +5V, -5V, etc.&lt;p&gt;
Please keep in mind, that these devices are necessary for the
automatic wiring of the supply signals.&lt;p&gt;
The pin name defined in the symbol is identical to the net which is to be wired automatically.&lt;p&gt;
In this library the device names are the same as the pin names of the symbols, therefore the correct signal names appear next to the supply symbols in the schematic.&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
</packages>
<symbols>
<symbol name="GND">
<wire x1="-1.27" y1="0" x2="1.27" y2="0" width="0.254" layer="94"/>
<wire x1="1.27" y1="0" x2="0" y2="-1.27" width="0.254" layer="94"/>
<wire x1="0" y1="-1.27" x2="-1.27" y2="0" width="0.254" layer="94"/>
<text x="-1.905" y="-3.175" size="1.778" layer="96">&gt;VALUE</text>
<pin name="GND" x="0" y="2.54" visible="off" length="short" direction="sup" rot="R270"/>
</symbol>
<symbol name="VCC">
<circle x="0" y="1.27" radius="1.27" width="0.254" layer="94"/>
<text x="-1.905" y="3.175" size="1.778" layer="96">&gt;VALUE</text>
<pin name="VCC" x="0" y="-2.54" visible="off" length="short" direction="sup" rot="R90"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="GND" prefix="SUPPLY">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;</description>
<gates>
<gate name="GND" symbol="GND" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="VCC" prefix="SUPPLY">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;</description>
<gates>
<gate name="G$1" symbol="VCC" x="0" y="0"/>
</gates>
<devices>
<device name="">
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
<package name="VIA_DIY">
<description>Via with wide target on bottom to allow slight alignement problems.</description>
<smd name="B" x="0" y="0" dx="5" dy="5" layer="16" roundness="100"/>
<smd name="T" x="0" y="0" dx="1" dy="1" layer="1" roundness="100"/>
<hole x="0" y="0" drill="0.8"/>
</package>
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
<rectangle x1="-9.5" y1="-4.5" x2="10" y2="4.5" layer="20"/>
<circle x="-7.62" y="2.54" radius="1.27" width="0.127" layer="21"/>
</package>
<package name="SOT223">
<description>&lt;b&gt;Small Outline Transistor&lt;/b&gt;</description>
<wire x1="3.277" y1="1.778" x2="3.277" y2="-1.778" width="0.2032" layer="21"/>
<wire x1="3.277" y1="-1.778" x2="-3.277" y2="-1.778" width="0.2032" layer="21"/>
<wire x1="-3.277" y1="-1.778" x2="-3.277" y2="1.778" width="0.2032" layer="21"/>
<wire x1="-3.277" y1="1.778" x2="3.277" y2="1.778" width="0.2032" layer="21"/>
<smd name="1" x="-2.311" y="-3.099" dx="1.219" dy="2.235" layer="1"/>
<smd name="2" x="0" y="-3.099" dx="1.219" dy="2.235" layer="1"/>
<smd name="3" x="2.311" y="-3.099" dx="1.219" dy="2.235" layer="1"/>
<smd name="4" x="0" y="3.099" dx="3.6" dy="2.2" layer="1"/>
<text x="-2.54" y="0.0508" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-1.3208" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.6002" y1="1.8034" x2="1.6002" y2="3.6576" layer="51"/>
<rectangle x1="-0.4318" y1="-3.6576" x2="0.4318" y2="-1.8034" layer="51"/>
<rectangle x1="-2.7432" y1="-3.6576" x2="-1.8796" y2="-1.8034" layer="51"/>
<rectangle x1="1.8796" y1="-3.6576" x2="2.7432" y2="-1.8034" layer="51"/>
<rectangle x1="-1.6002" y1="1.8034" x2="1.6002" y2="3.6576" layer="51"/>
<rectangle x1="-0.4318" y1="-3.6576" x2="0.4318" y2="-1.8034" layer="51"/>
<rectangle x1="-2.7432" y1="-3.6576" x2="-1.8796" y2="-1.8034" layer="51"/>
<rectangle x1="1.8796" y1="-3.6576" x2="2.7432" y2="-1.8034" layer="51"/>
</package>
</packages>
<symbols>
<symbol name="VIA_DIY">
<pin name="B" x="5.08" y="0" length="point" rot="R180"/>
<pin name="T" x="-5.08" y="0" length="point"/>
<circle x="0" y="0" radius="1.27" width="0.254" layer="94"/>
<wire x1="5.08" y1="0" x2="-5.08" y2="0" width="0.254" layer="94"/>
</symbol>
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
<symbol name="VREG">
<pin name="VCC" x="-7.62" y="2.54" length="middle"/>
<pin name="GND" x="-7.62" y="-5.08" length="middle"/>
<pin name="VOUT1" x="22.86" y="2.54" length="middle" rot="R180"/>
<pin name="VOUT2" x="22.86" y="-5.08" length="middle" rot="R180"/>
<wire x1="-2.54" y1="7.62" x2="17.78" y2="7.62" width="0.254" layer="94"/>
<wire x1="17.78" y1="7.62" x2="17.78" y2="-10.16" width="0.254" layer="94"/>
<wire x1="17.78" y1="-10.16" x2="-2.54" y2="-10.16" width="0.254" layer="94"/>
<wire x1="-2.54" y1="-10.16" x2="-2.54" y2="7.62" width="0.254" layer="94"/>
<text x="5.08" y="5.08" size="1.778" layer="94">VREG</text>
<text x="2.54" y="-2.54" size="1.778" layer="94">&gt;VALUE</text>
</symbol>
</symbols>
<devicesets>
<deviceset name="VIA_DIY">
<gates>
<gate name="G$1" symbol="VIA_DIY" x="0" y="0"/>
</gates>
<devices>
<device name="" package="VIA_DIY">
<connects>
<connect gate="G$1" pin="B" pad="B"/>
<connect gate="G$1" pin="T" pad="T"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
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
<deviceset name="NX1117" uservalue="yes">
<gates>
<gate name="G$1" symbol="VREG" x="-5.08" y="0"/>
</gates>
<devices>
<device name="" package="SOT223">
<connects>
<connect gate="G$1" pin="GND" pad="1"/>
<connect gate="G$1" pin="VCC" pad="3"/>
<connect gate="G$1" pin="VOUT1" pad="4"/>
<connect gate="G$1" pin="VOUT2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="smd-special">
<packages>
<package name="VO20">
<wire x1="-0.4" y1="0.675" x2="-0.4" y2="5.175" width="0.15" layer="21"/>
<wire x1="-0.4" y1="5.175" x2="6.2" y2="5.175" width="0.15" layer="21"/>
<wire x1="6.2" y1="5.175" x2="6.2" y2="0.675" width="0.15" layer="21"/>
<wire x1="6.2" y1="0.675" x2="-0.4" y2="0.675" width="0.15" layer="21"/>
<circle x="5.4" y="4.4" radius="0.4123" width="0.15" layer="21"/>
<smd name="11" x="0" y="-0.3" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<smd name="12" x="0.65" y="-0.3" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<smd name="13" x="1.3" y="-0.3" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<smd name="14" x="1.95" y="-0.3" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<smd name="15" x="2.6" y="-0.3" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<smd name="16" x="3.25" y="-0.3" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<smd name="17" x="3.9" y="-0.3" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<smd name="18" x="4.55" y="-0.3" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<smd name="19" x="5.2" y="-0.3" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<smd name="20" x="5.85" y="-0.3" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<smd name="1" x="5.85" y="6.15" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<smd name="2" x="5.2" y="6.15" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<smd name="3" x="4.55" y="6.15" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<smd name="4" x="3.9" y="6.15" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<smd name="5" x="3.25" y="6.15" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<smd name="6" x="2.6" y="6.15" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<smd name="7" x="1.95" y="6.15" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<smd name="8" x="1.3" y="6.15" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<smd name="9" x="0.65" y="6.15" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<smd name="10" x="0" y="6.15" dx="1.8" dy="0.4" layer="1" rot="R90"/>
<text x="7.9375" y="-0.3175" size="1.27" layer="25" rot="R90">&gt;NAME</text>
<text x="-0.9525" y="-0.3175" size="1.27" layer="27" rot="R90">&gt;VALUE</text>
</package>
</packages>
<symbols>
<symbol name="XCF02">
<wire x1="0" y1="-7.62" x2="0" y2="33.02" width="0.254" layer="94"/>
<wire x1="0" y1="33.02" x2="25.4" y2="33.02" width="0.254" layer="94"/>
<wire x1="25.4" y1="33.02" x2="25.4" y2="-7.62" width="0.254" layer="94"/>
<wire x1="25.4" y1="-7.62" x2="0" y2="-7.62" width="0.254" layer="94"/>
<text x="0" y="-10.16" size="1.6764" layer="95">&gt;NAME</text>
<text x="13.97" y="-10.16" size="1.6764" layer="96">&gt;VALUE</text>
<pin name="VCCJ" x="-5.08" y="30.48" length="middle"/>
<pin name="VCCINT" x="-5.08" y="27.94" length="middle"/>
<pin name="VCCO" x="-5.08" y="25.4" length="middle"/>
<pin name="TDI" x="-5.08" y="20.32" length="middle"/>
<pin name="TMS" x="-5.08" y="17.78" length="middle"/>
<pin name="TCK" x="-5.08" y="15.24" length="middle"/>
<pin name="GND" x="-5.08" y="5.08" length="middle"/>
<pin name="TDO" x="30.48" y="5.08" length="middle" rot="R180"/>
<pin name="/CF" x="30.48" y="10.16" length="middle" rot="R180"/>
<pin name="OE/RESET" x="30.48" y="12.7" length="middle" rot="R180"/>
<pin name="/CEO" x="30.48" y="15.24" length="middle" rot="R180"/>
<pin name="/CE" x="30.48" y="17.78" length="middle" rot="R180"/>
<pin name="CLK" x="30.48" y="20.32" length="middle" rot="R180"/>
<pin name="DO" x="30.48" y="30.48" length="middle" rot="R180"/>
<pin name="NC.1" x="-5.08" y="0" length="middle"/>
<pin name="NC.2" x="-5.08" y="-2.54" length="middle"/>
<pin name="NC.3" x="-5.08" y="-5.08" length="middle"/>
<pin name="NC.4" x="30.48" y="0" length="middle" rot="R180"/>
<pin name="NC.5" x="30.48" y="-2.54" length="middle" rot="R180"/>
<pin name="NC.6" x="30.48" y="-5.08" length="middle" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="XCF02S" prefix="IC">
<gates>
<gate name="G$1" symbol="XCF02" x="0" y="7.62"/>
</gates>
<devices>
<device name="" package="VO20">
<connects>
<connect gate="G$1" pin="/CE" pad="10"/>
<connect gate="G$1" pin="/CEO" pad="13"/>
<connect gate="G$1" pin="/CF" pad="7"/>
<connect gate="G$1" pin="CLK" pad="3"/>
<connect gate="G$1" pin="DO" pad="1"/>
<connect gate="G$1" pin="GND" pad="11"/>
<connect gate="G$1" pin="NC.1" pad="2"/>
<connect gate="G$1" pin="NC.2" pad="9"/>
<connect gate="G$1" pin="NC.3" pad="12"/>
<connect gate="G$1" pin="NC.4" pad="14"/>
<connect gate="G$1" pin="NC.5" pad="15"/>
<connect gate="G$1" pin="NC.6" pad="16"/>
<connect gate="G$1" pin="OE/RESET" pad="8"/>
<connect gate="G$1" pin="TCK" pad="6"/>
<connect gate="G$1" pin="TDI" pad="4"/>
<connect gate="G$1" pin="TDO" pad="17"/>
<connect gate="G$1" pin="TMS" pad="5"/>
<connect gate="G$1" pin="VCCINT" pad="18"/>
<connect gate="G$1" pin="VCCJ" pad="20"/>
<connect gate="G$1" pin="VCCO" pad="19"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="rcl">
<description>&lt;b&gt;Resistors, Capacitors, Inductors&lt;/b&gt;&lt;p&gt;
Based on the previous libraries:
&lt;ul&gt;
&lt;li&gt;r.lbr
&lt;li&gt;cap.lbr 
&lt;li&gt;cap-fe.lbr
&lt;li&gt;captant.lbr
&lt;li&gt;polcap.lbr
&lt;li&gt;ipc-smd.lbr
&lt;/ul&gt;
All SMD packages are defined according to the IPC specifications and  CECC&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;&lt;p&gt;
&lt;p&gt;
for Electrolyt Capacitors see also :&lt;p&gt;
www.bccomponents.com &lt;p&gt;
www.panasonic.com&lt;p&gt;
www.kemet.com&lt;p&gt;
http://www.secc.co.jp/pdf/os_e/2004/e_os_all.pdf &lt;b&gt;(SANYO)&lt;/b&gt;
&lt;p&gt;
for trimmer refence see : &lt;u&gt;www.electrospec-inc.com/cross_references/trimpotcrossref.asp&lt;/u&gt;&lt;p&gt;

&lt;table border=0 cellspacing=0 cellpadding=0 width="100%" cellpaddding=0&gt;
&lt;tr valign="top"&gt;

&lt;! &lt;td width="10"&gt;&amp;nbsp;&lt;/td&gt;
&lt;td width="90%"&gt;

&lt;b&gt;&lt;font color="#0000FF" size="4"&gt;TRIM-POT CROSS REFERENCE&lt;/font&gt;&lt;/b&gt;
&lt;P&gt;
&lt;TABLE BORDER=0 CELLSPACING=1 CELLPADDING=2&gt;
  &lt;TR&gt;
    &lt;TD COLSPAN=8&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;RECTANGULAR MULTI-TURN&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#FF0000"&gt;BOURNS&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#FF0000"&gt;BI&amp;nbsp;TECH&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#FF0000"&gt;DALE-VISHAY&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#FF0000"&gt;PHILIPS/MEPCO&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#FF0000"&gt;MURATA&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#FF0000"&gt;PANASONIC&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#FF0000"&gt;SPECTROL&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;B&gt;
      &lt;FONT SIZE=3 FACE=ARIAL color="#FF0000"&gt;MILSPEC&lt;/FONT&gt;
      &lt;/B&gt;
    &lt;/TD&gt;&lt;TD&gt;&amp;nbsp;&lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3 &gt;
      3005P&lt;BR&gt;
      3006P&lt;BR&gt;
      3006W&lt;BR&gt;
      3006Y&lt;BR&gt;
      3009P&lt;BR&gt;
      3009W&lt;BR&gt;
      3009Y&lt;BR&gt;
      3057J&lt;BR&gt;
      3057L&lt;BR&gt;
      3057P&lt;BR&gt;
      3057Y&lt;BR&gt;
      3059J&lt;BR&gt;
      3059L&lt;BR&gt;
      3059P&lt;BR&gt;
      3059Y&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      89P&lt;BR&gt;
      89W&lt;BR&gt;
      89X&lt;BR&gt;
      89PH&lt;BR&gt;
      76P&lt;BR&gt;
      89XH&lt;BR&gt;
      78SLT&lt;BR&gt;
      78L&amp;nbsp;ALT&lt;BR&gt;
      56P&amp;nbsp;ALT&lt;BR&gt;
      78P&amp;nbsp;ALT&lt;BR&gt;
      T8S&lt;BR&gt;
      78L&lt;BR&gt;
      56P&lt;BR&gt;
      78P&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      T18/784&lt;BR&gt;
      783&lt;BR&gt;
      781&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      2199&lt;BR&gt;
      1697/1897&lt;BR&gt;
      1680/1880&lt;BR&gt;
      2187&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      8035EKP/CT20/RJ-20P&lt;BR&gt;
      -&lt;BR&gt;
      RJ-20X&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      1211L&lt;BR&gt;
      8012EKQ&amp;nbsp;ALT&lt;BR&gt;
      8012EKR&amp;nbsp;ALT&lt;BR&gt;
      1211P&lt;BR&gt;
      8012EKJ&lt;BR&gt;
      8012EKL&lt;BR&gt;
      8012EKQ&lt;BR&gt;
      8012EKR&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      2101P&lt;BR&gt;
      2101W&lt;BR&gt;
      2101Y&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      2102L&lt;BR&gt;
      2102S&lt;BR&gt;
      2102Y&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      EVMCOG&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      43P&lt;BR&gt;
      43W&lt;BR&gt;
      43Y&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      40L&lt;BR&gt;
      40P&lt;BR&gt;
      40Y&lt;BR&gt;
      70Y-T602&lt;BR&gt;
      70L&lt;BR&gt;
      70P&lt;BR&gt;
      70Y&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      RT/RTR12&lt;BR&gt;
      RT/RTR12&lt;BR&gt;
      RT/RTR12&lt;BR&gt;
      -&lt;BR&gt;
      RJ/RJR12&lt;BR&gt;
      RJ/RJR12&lt;BR&gt;
      RJ/RJR12&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD COLSPAN=8&gt;&amp;nbsp;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD COLSPAN=8&gt;
      &lt;FONT SIZE=4 FACE=ARIAL&gt;&lt;B&gt;SQUARE MULTI-TURN&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
   &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;BOURN&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;BI&amp;nbsp;TECH&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;DALE-VISHAY&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;PHILIPS/MEPCO&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;MURATA&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;PANASONIC&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;SPECTROL&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;MILSPEC&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      3250L&lt;BR&gt;
      3250P&lt;BR&gt;
      3250W&lt;BR&gt;
      3250X&lt;BR&gt;
      3252P&lt;BR&gt;
      3252W&lt;BR&gt;
      3252X&lt;BR&gt;
      3260P&lt;BR&gt;
      3260W&lt;BR&gt;
      3260X&lt;BR&gt;
      3262P&lt;BR&gt;
      3262W&lt;BR&gt;
      3262X&lt;BR&gt;
      3266P&lt;BR&gt;
      3266W&lt;BR&gt;
      3266X&lt;BR&gt;
      3290H&lt;BR&gt;
      3290P&lt;BR&gt;
      3290W&lt;BR&gt;
      3292P&lt;BR&gt;
      3292W&lt;BR&gt;
      3292X&lt;BR&gt;
      3296P&lt;BR&gt;
      3296W&lt;BR&gt;
      3296X&lt;BR&gt;
      3296Y&lt;BR&gt;
      3296Z&lt;BR&gt;
      3299P&lt;BR&gt;
      3299W&lt;BR&gt;
      3299X&lt;BR&gt;
      3299Y&lt;BR&gt;
      3299Z&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      66P&amp;nbsp;ALT&lt;BR&gt;
      66W&amp;nbsp;ALT&lt;BR&gt;
      66X&amp;nbsp;ALT&lt;BR&gt;
      66P&amp;nbsp;ALT&lt;BR&gt;
      66W&amp;nbsp;ALT&lt;BR&gt;
      66X&amp;nbsp;ALT&lt;BR&gt;
      -&lt;BR&gt;
      64W&amp;nbsp;ALT&lt;BR&gt;
      -&lt;BR&gt;
      64P&amp;nbsp;ALT&lt;BR&gt;
      64W&amp;nbsp;ALT&lt;BR&gt;
      64X&amp;nbsp;ALT&lt;BR&gt;
      64P&lt;BR&gt;
      64W&lt;BR&gt;
      64X&lt;BR&gt;
      66X&amp;nbsp;ALT&lt;BR&gt;
      66P&amp;nbsp;ALT&lt;BR&gt;
      66W&amp;nbsp;ALT&lt;BR&gt;
      66P&lt;BR&gt;
      66W&lt;BR&gt;
      66X&lt;BR&gt;
      67P&lt;BR&gt;
      67W&lt;BR&gt;
      67X&lt;BR&gt;
      67Y&lt;BR&gt;
      67Z&lt;BR&gt;
      68P&lt;BR&gt;
      68W&lt;BR&gt;
      68X&lt;BR&gt;
      67Y&amp;nbsp;ALT&lt;BR&gt;
      67Z&amp;nbsp;ALT&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      5050&lt;BR&gt;
      5091&lt;BR&gt;
      5080&lt;BR&gt;
      5087&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      T63YB&lt;BR&gt;
      T63XB&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      5887&lt;BR&gt;
      5891&lt;BR&gt;
      5880&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      T93Z&lt;BR&gt;
      T93YA&lt;BR&gt;
      T93XA&lt;BR&gt;
      T93YB&lt;BR&gt;
      T93XB&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      8026EKP&lt;BR&gt;
      8026EKW&lt;BR&gt;
      8026EKM&lt;BR&gt;
      8026EKP&lt;BR&gt;
      8026EKB&lt;BR&gt;
      8026EKM&lt;BR&gt;
      1309X&lt;BR&gt;
      1309P&lt;BR&gt;
      1309W&lt;BR&gt;
      8024EKP&lt;BR&gt;
      8024EKW&lt;BR&gt;
      8024EKN&lt;BR&gt;
      RJ-9P/CT9P&lt;BR&gt;
      RJ-9W&lt;BR&gt;
      RJ-9X&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      3103P&lt;BR&gt;
      3103Y&lt;BR&gt;
      3103Z&lt;BR&gt;
      3103P&lt;BR&gt;
      3103Y&lt;BR&gt;
      3103Z&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      3105P/3106P&lt;BR&gt;
      3105W/3106W&lt;BR&gt;
      3105X/3106X&lt;BR&gt;
      3105Y/3106Y&lt;BR&gt;
      3105Z/3105Z&lt;BR&gt;
      3102P&lt;BR&gt;
      3102W&lt;BR&gt;
      3102X&lt;BR&gt;
      3102Y&lt;BR&gt;
      3102Z&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      EVMCBG&lt;BR&gt;
      EVMCCG&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      55-1-X&lt;BR&gt;
      55-4-X&lt;BR&gt;
      55-3-X&lt;BR&gt;
      55-2-X&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      50-2-X&lt;BR&gt;
      50-4-X&lt;BR&gt;
      50-3-X&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      64P&lt;BR&gt;
      64W&lt;BR&gt;
      64X&lt;BR&gt;
      64Y&lt;BR&gt;
      64Z&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      RT/RTR22&lt;BR&gt;
      RT/RTR22&lt;BR&gt;
      RT/RTR22&lt;BR&gt;
      RT/RTR22&lt;BR&gt;
      RJ/RJR22&lt;BR&gt;
      RJ/RJR22&lt;BR&gt;
      RJ/RJR22&lt;BR&gt;
      RT/RTR26&lt;BR&gt;
      RT/RTR26&lt;BR&gt;
      RT/RTR26&lt;BR&gt;
      RJ/RJR26&lt;BR&gt;
      RJ/RJR26&lt;BR&gt;
      RJ/RJR26&lt;BR&gt;
      RJ/RJR26&lt;BR&gt;
      RJ/RJR26&lt;BR&gt;
      RJ/RJR26&lt;BR&gt;
      RT/RTR24&lt;BR&gt;
      RT/RTR24&lt;BR&gt;
      RT/RTR24&lt;BR&gt;
      RJ/RJR24&lt;BR&gt;
      RJ/RJR24&lt;BR&gt;
      RJ/RJR24&lt;BR&gt;
      RJ/RJR24&lt;BR&gt;
      RJ/RJR24&lt;BR&gt;
      RJ/RJR24&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD COLSPAN=8&gt;&amp;nbsp;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD COLSPAN=8&gt;
      &lt;FONT SIZE=4 FACE=ARIAL&gt;&lt;B&gt;SINGLE TURN&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;BOURN&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;BI&amp;nbsp;TECH&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;DALE-VISHAY&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;PHILIPS/MEPCO&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;MURATA&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;PANASONIC&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;SPECTROL&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD ALIGN=CENTER&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;MILSPEC&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      3323P&lt;BR&gt;
      3323S&lt;BR&gt;
      3323W&lt;BR&gt;
      3329H&lt;BR&gt;
      3329P&lt;BR&gt;
      3329W&lt;BR&gt;
      3339H&lt;BR&gt;
      3339P&lt;BR&gt;
      3339W&lt;BR&gt;
      3352E&lt;BR&gt;
      3352H&lt;BR&gt;
      3352K&lt;BR&gt;
      3352P&lt;BR&gt;
      3352T&lt;BR&gt;
      3352V&lt;BR&gt;
      3352W&lt;BR&gt;
      3362H&lt;BR&gt;
      3362M&lt;BR&gt;
      3362P&lt;BR&gt;
      3362R&lt;BR&gt;
      3362S&lt;BR&gt;
      3362U&lt;BR&gt;
      3362W&lt;BR&gt;
      3362X&lt;BR&gt;
      3386B&lt;BR&gt;
      3386C&lt;BR&gt;
      3386F&lt;BR&gt;
      3386H&lt;BR&gt;
      3386K&lt;BR&gt;
      3386M&lt;BR&gt;
      3386P&lt;BR&gt;
      3386S&lt;BR&gt;
      3386W&lt;BR&gt;
      3386X&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      25P&lt;BR&gt;
      25S&lt;BR&gt;
      25RX&lt;BR&gt;
      82P&lt;BR&gt;
      82M&lt;BR&gt;
      82PA&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      91E&lt;BR&gt;
      91X&lt;BR&gt;
      91T&lt;BR&gt;
      91B&lt;BR&gt;
      91A&lt;BR&gt;
      91V&lt;BR&gt;
      91W&lt;BR&gt;
      25W&lt;BR&gt;
      25V&lt;BR&gt;
      25P&lt;BR&gt;
      -&lt;BR&gt;
      25S&lt;BR&gt;
      25U&lt;BR&gt;
      25RX&lt;BR&gt;
      25X&lt;BR&gt;
      72XW&lt;BR&gt;
      72XL&lt;BR&gt;
      72PM&lt;BR&gt;
      72RX&lt;BR&gt;
      -&lt;BR&gt;
      72PX&lt;BR&gt;
      72P&lt;BR&gt;
      72RXW&lt;BR&gt;
      72RXL&lt;BR&gt;
      72X&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      T7YB&lt;BR&gt;
      T7YA&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      TXD&lt;BR&gt;
      TYA&lt;BR&gt;
      TYP&lt;BR&gt;
      -&lt;BR&gt;
      TYD&lt;BR&gt;
      TX&lt;BR&gt;
      -&lt;BR&gt;
      150SX&lt;BR&gt;
      100SX&lt;BR&gt;
      102T&lt;BR&gt;
      101S&lt;BR&gt;
      190T&lt;BR&gt;
      150TX&lt;BR&gt;
      101&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      101SX&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      ET6P&lt;BR&gt;
      ET6S&lt;BR&gt;
      ET6X&lt;BR&gt;
      RJ-6W/8014EMW&lt;BR&gt;
      RJ-6P/8014EMP&lt;BR&gt;
      RJ-6X/8014EMX&lt;BR&gt;
      TM7W&lt;BR&gt;
      TM7P&lt;BR&gt;
      TM7X&lt;BR&gt;
      -&lt;BR&gt;
      8017SMS&lt;BR&gt;
      -&lt;BR&gt;
      8017SMB&lt;BR&gt;
      8017SMA&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      CT-6W&lt;BR&gt;
      CT-6H&lt;BR&gt;
      CT-6P&lt;BR&gt;
      CT-6R&lt;BR&gt;
      -&lt;BR&gt;
      CT-6V&lt;BR&gt;
      CT-6X&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      8038EKV&lt;BR&gt;
      -&lt;BR&gt;
      8038EKX&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      8038EKP&lt;BR&gt;
      8038EKZ&lt;BR&gt;
      8038EKW&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      3321H&lt;BR&gt;
      3321P&lt;BR&gt;
      3321N&lt;BR&gt;
      1102H&lt;BR&gt;
      1102P&lt;BR&gt;
      1102T&lt;BR&gt;
      RVA0911V304A&lt;BR&gt;
      -&lt;BR&gt;
      RVA0911H413A&lt;BR&gt;
      RVG0707V100A&lt;BR&gt;
      RVA0607V(H)306A&lt;BR&gt;
      RVA1214H213A&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      3104B&lt;BR&gt;
      3104C&lt;BR&gt;
      3104F&lt;BR&gt;
      3104H&lt;BR&gt;
      -&lt;BR&gt;
      3104M&lt;BR&gt;
      3104P&lt;BR&gt;
      3104S&lt;BR&gt;
      3104W&lt;BR&gt;
      3104X&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      EVMQ0G&lt;BR&gt;
      EVMQIG&lt;BR&gt;
      EVMQ3G&lt;BR&gt;
      EVMS0G&lt;BR&gt;
      EVMQ0G&lt;BR&gt;
      EVMG0G&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      EVMK4GA00B&lt;BR&gt;
      EVM30GA00B&lt;BR&gt;
      EVMK0GA00B&lt;BR&gt;
      EVM38GA00B&lt;BR&gt;
      EVMB6&lt;BR&gt;
      EVLQ0&lt;BR&gt;
      -&lt;BR&gt;
      EVMMSG&lt;BR&gt;
      EVMMBG&lt;BR&gt;
      EVMMAG&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      EVMMCS&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      EVMM1&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      EVMM0&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      EVMM3&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      62-3-1&lt;BR&gt;
      62-1-2&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      67R&lt;BR&gt;
      -&lt;BR&gt;
      67P&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      67X&lt;BR&gt;
      63V&lt;BR&gt;
      63S&lt;BR&gt;
      63M&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      63H&lt;BR&gt;
      63P&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      63X&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      RJ/RJR50&lt;BR&gt;
      RJ/RJR50&lt;BR&gt;
      RJ/RJR50&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
&lt;/TABLE&gt;
&lt;P&gt;&amp;nbsp;&lt;P&gt;
&lt;TABLE BORDER=0 CELLSPACING=1 CELLPADDING=3&gt;
  &lt;TR&gt;
    &lt;TD COLSPAN=7&gt;
      &lt;FONT color="#0000FF" SIZE=4 FACE=ARIAL&gt;&lt;B&gt;SMD TRIM-POT CROSS REFERENCE&lt;/B&gt;&lt;/FONT&gt;
      &lt;P&gt;
      &lt;FONT SIZE=4 FACE=ARIAL&gt;&lt;B&gt;MULTI-TURN&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;BOURNS&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;BI&amp;nbsp;TECH&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;DALE-VISHAY&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;PHILIPS/MEPCO&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;PANASONIC&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;TOCOS&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;AUX/KYOCERA&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      3224G&lt;BR&gt;
      3224J&lt;BR&gt;
      3224W&lt;BR&gt;
      3269P&lt;BR&gt;
      3269W&lt;BR&gt;
      3269X&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      44G&lt;BR&gt;
      44J&lt;BR&gt;
      44W&lt;BR&gt;
      84P&lt;BR&gt;
      84W&lt;BR&gt;
      84X&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      ST63Z&lt;BR&gt;
      ST63Y&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      ST5P&lt;BR&gt;
      ST5W&lt;BR&gt;
      ST5X&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD COLSPAN=7&gt;&amp;nbsp;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD COLSPAN=7&gt;
      &lt;FONT SIZE=4 FACE=ARIAL&gt;&lt;B&gt;SINGLE TURN&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;BOURNS&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;BI&amp;nbsp;TECH&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;DALE-VISHAY&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;PHILIPS/MEPCO&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;PANASONIC&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;TOCOS&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD&gt;
      &lt;FONT SIZE=3 FACE=ARIAL&gt;&lt;B&gt;AUX/KYOCERA&lt;/B&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
  &lt;TR&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      3314G&lt;BR&gt;
      3314J&lt;BR&gt;
      3364A/B&lt;BR&gt;
      3364C/D&lt;BR&gt;
      3364W/X&lt;BR&gt;
      3313G&lt;BR&gt;
      3313J&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      23B&lt;BR&gt;
      23A&lt;BR&gt;
      21X&lt;BR&gt;
      21W&lt;BR&gt;
      -&lt;BR&gt;
      22B&lt;BR&gt;
      22A&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      ST5YL/ST53YL&lt;BR&gt;
      ST5YJ/5T53YJ&lt;BR&gt;
      ST-23A&lt;BR&gt;
      ST-22B&lt;BR&gt;
      ST-22&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      ST-4B&lt;BR&gt;
      ST-4A&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      ST-3B&lt;BR&gt;
      ST-3A&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      EVM-6YS&lt;BR&gt;
      EVM-1E&lt;BR&gt;
      EVM-1G&lt;BR&gt;
      EVM-1D&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      G4B&lt;BR&gt;
      G4A&lt;BR&gt;
      TR04-3S1&lt;BR&gt;
      TRG04-2S1&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
    &lt;TD BGCOLOR="#cccccc" ALIGN=CENTER&gt;&lt;FONT FACE=ARIAL SIZE=3&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;
      DVR-43A&lt;BR&gt;
      CVR-42C&lt;BR&gt;
      CVR-42A/C&lt;BR&gt;
      -&lt;BR&gt;
      -&lt;BR&gt;&lt;/FONT&gt;
    &lt;/TD&gt;
  &lt;/TR&gt;
&lt;/TABLE&gt;
&lt;P&gt;
&lt;FONT SIZE=4 FACE=ARIAL&gt;&lt;B&gt;ALT =&amp;nbsp;ALTERNATE&lt;/B&gt;&lt;/FONT&gt;
&lt;P&gt;

&amp;nbsp;
&lt;P&gt;
&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;</description>
<packages>
<package name="R0402">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="-0.245" y1="0.224" x2="0.245" y2="0.224" width="0.1524" layer="51"/>
<wire x1="0.245" y1="-0.224" x2="-0.245" y2="-0.224" width="0.1524" layer="51"/>
<wire x1="-1.473" y1="0.483" x2="1.473" y2="0.483" width="0.0508" layer="39"/>
<wire x1="1.473" y1="0.483" x2="1.473" y2="-0.483" width="0.0508" layer="39"/>
<wire x1="1.473" y1="-0.483" x2="-1.473" y2="-0.483" width="0.0508" layer="39"/>
<wire x1="-1.473" y1="-0.483" x2="-1.473" y2="0.483" width="0.0508" layer="39"/>
<smd name="1" x="-0.65" y="0" dx="0.7" dy="0.9" layer="1"/>
<smd name="2" x="0.65" y="0" dx="0.7" dy="0.9" layer="1"/>
<text x="-0.635" y="0.635" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-1.905" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.554" y1="-0.3048" x2="-0.254" y2="0.2951" layer="51"/>
<rectangle x1="0.2588" y1="-0.3048" x2="0.5588" y2="0.2951" layer="51"/>
<rectangle x1="-0.1999" y1="-0.4001" x2="0.1999" y2="0.4001" layer="35"/>
</package>
<package name="R0603">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="-0.432" y1="-0.356" x2="0.432" y2="-0.356" width="0.1524" layer="51"/>
<wire x1="0.432" y1="0.356" x2="-0.432" y2="0.356" width="0.1524" layer="51"/>
<wire x1="-1.473" y1="0.983" x2="1.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.473" y1="0.983" x2="1.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.473" y1="-0.983" x2="-1.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.473" y1="-0.983" x2="-1.473" y2="0.983" width="0.0508" layer="39"/>
<smd name="1" x="-0.85" y="0" dx="1" dy="1.1" layer="1"/>
<smd name="2" x="0.85" y="0" dx="1" dy="1.1" layer="1"/>
<text x="-0.635" y="0.635" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-1.905" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="0.4318" y1="-0.4318" x2="0.8382" y2="0.4318" layer="51"/>
<rectangle x1="-0.8382" y1="-0.4318" x2="-0.4318" y2="0.4318" layer="51"/>
<rectangle x1="-0.1999" y1="-0.4001" x2="0.1999" y2="0.4001" layer="35"/>
</package>
<package name="R0805">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;</description>
<wire x1="-0.41" y1="0.635" x2="0.41" y2="0.635" width="0.1524" layer="51"/>
<wire x1="-0.41" y1="-0.635" x2="0.41" y2="-0.635" width="0.1524" layer="51"/>
<wire x1="-1.973" y1="0.983" x2="1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="0.983" x2="1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="-0.983" x2="-1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.973" y1="-0.983" x2="-1.973" y2="0.983" width="0.0508" layer="39"/>
<smd name="1" x="-0.95" y="0" dx="1.3" dy="1.5" layer="1"/>
<smd name="2" x="0.95" y="0" dx="1.3" dy="1.5" layer="1"/>
<text x="-0.635" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="0.4064" y1="-0.6985" x2="1.0564" y2="0.7015" layer="51"/>
<rectangle x1="-1.0668" y1="-0.6985" x2="-0.4168" y2="0.7015" layer="51"/>
<rectangle x1="-0.1999" y1="-0.5001" x2="0.1999" y2="0.5001" layer="35"/>
</package>
<package name="R0805W">
<description>&lt;b&gt;RESISTOR&lt;/b&gt; wave soldering&lt;p&gt;</description>
<wire x1="-0.41" y1="0.635" x2="0.41" y2="0.635" width="0.1524" layer="51"/>
<wire x1="-0.41" y1="-0.635" x2="0.41" y2="-0.635" width="0.1524" layer="51"/>
<wire x1="-1.973" y1="0.983" x2="1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="0.983" x2="1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="-0.983" x2="-1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.973" y1="-0.983" x2="-1.973" y2="0.983" width="0.0508" layer="39"/>
<smd name="1" x="-1.0525" y="0" dx="1.5" dy="1" layer="1"/>
<smd name="2" x="1.0525" y="0" dx="1.5" dy="1" layer="1"/>
<text x="-0.635" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="0.4064" y1="-0.6985" x2="1.0564" y2="0.7015" layer="51"/>
<rectangle x1="-1.0668" y1="-0.6985" x2="-0.4168" y2="0.7015" layer="51"/>
<rectangle x1="-0.1999" y1="-0.5001" x2="0.1999" y2="0.5001" layer="35"/>
</package>
<package name="R1005">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="-0.245" y1="0.224" x2="0.245" y2="0.224" width="0.1524" layer="51"/>
<wire x1="0.245" y1="-0.224" x2="-0.245" y2="-0.224" width="0.1524" layer="51"/>
<wire x1="-1.473" y1="0.483" x2="1.473" y2="0.483" width="0.0508" layer="39"/>
<wire x1="1.473" y1="0.483" x2="1.473" y2="-0.483" width="0.0508" layer="39"/>
<wire x1="1.473" y1="-0.483" x2="-1.473" y2="-0.483" width="0.0508" layer="39"/>
<wire x1="-1.473" y1="-0.483" x2="-1.473" y2="0.483" width="0.0508" layer="39"/>
<smd name="1" x="-0.65" y="0" dx="0.7" dy="0.9" layer="1"/>
<smd name="2" x="0.65" y="0" dx="0.7" dy="0.9" layer="1"/>
<text x="-0.635" y="0.635" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-1.905" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.554" y1="-0.3048" x2="-0.254" y2="0.2951" layer="51"/>
<rectangle x1="0.2588" y1="-0.3048" x2="0.5588" y2="0.2951" layer="51"/>
<rectangle x1="-0.1999" y1="-0.3" x2="0.1999" y2="0.3" layer="35"/>
</package>
<package name="R1206">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="0.9525" y1="-0.8128" x2="-0.9652" y2="-0.8128" width="0.1524" layer="51"/>
<wire x1="0.9525" y1="0.8128" x2="-0.9652" y2="0.8128" width="0.1524" layer="51"/>
<wire x1="-2.473" y1="0.983" x2="2.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="0.983" x2="2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-0.983" x2="-2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-0.983" x2="-2.473" y2="0.983" width="0.0508" layer="39"/>
<smd name="2" x="1.422" y="0" dx="1.6" dy="1.803" layer="1"/>
<smd name="1" x="-1.422" y="0" dx="1.6" dy="1.803" layer="1"/>
<text x="-1.27" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.6891" y1="-0.8763" x2="-0.9525" y2="0.8763" layer="51"/>
<rectangle x1="0.9525" y1="-0.8763" x2="1.6891" y2="0.8763" layer="51"/>
<rectangle x1="-0.3" y1="-0.7" x2="0.3" y2="0.7" layer="35"/>
</package>
<package name="R1206W">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
wave soldering</description>
<wire x1="-0.913" y1="0.8" x2="0.888" y2="0.8" width="0.1524" layer="51"/>
<wire x1="-0.913" y1="-0.8" x2="0.888" y2="-0.8" width="0.1524" layer="51"/>
<wire x1="-2.473" y1="0.983" x2="2.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="0.983" x2="2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-0.983" x2="-2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-0.983" x2="-2.473" y2="0.983" width="0.0508" layer="39"/>
<smd name="1" x="-1.499" y="0" dx="1.8" dy="1.2" layer="1"/>
<smd name="2" x="1.499" y="0" dx="1.8" dy="1.2" layer="1"/>
<text x="-1.905" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.905" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.651" y1="-0.8763" x2="-0.9009" y2="0.8738" layer="51"/>
<rectangle x1="0.889" y1="-0.8763" x2="1.6391" y2="0.8738" layer="51"/>
<rectangle x1="-0.3" y1="-0.7" x2="0.3" y2="0.7" layer="35"/>
</package>
<package name="R1210">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="-0.913" y1="1.219" x2="0.939" y2="1.219" width="0.1524" layer="51"/>
<wire x1="-0.913" y1="-1.219" x2="0.939" y2="-1.219" width="0.1524" layer="51"/>
<wire x1="-2.473" y1="1.483" x2="2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="1.483" x2="2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-1.483" x2="-2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-1.483" x2="-2.473" y2="1.483" width="0.0508" layer="39"/>
<smd name="1" x="-1.4" y="0" dx="1.6" dy="2.7" layer="1"/>
<smd name="2" x="1.4" y="0" dx="1.6" dy="2.7" layer="1"/>
<text x="-2.54" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.651" y1="-1.3081" x2="-0.9009" y2="1.2918" layer="51"/>
<rectangle x1="0.9144" y1="-1.3081" x2="1.6645" y2="1.2918" layer="51"/>
<rectangle x1="-0.3" y1="-0.8999" x2="0.3" y2="0.8999" layer="35"/>
</package>
<package name="R1210W">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
wave soldering</description>
<wire x1="-0.913" y1="1.219" x2="0.939" y2="1.219" width="0.1524" layer="51"/>
<wire x1="-0.913" y1="-1.219" x2="0.939" y2="-1.219" width="0.1524" layer="51"/>
<wire x1="-2.473" y1="1.483" x2="2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="1.483" x2="2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-1.483" x2="-2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-1.483" x2="-2.473" y2="1.483" width="0.0508" layer="39"/>
<smd name="1" x="-1.499" y="0" dx="1.8" dy="1.8" layer="1"/>
<smd name="2" x="1.499" y="0" dx="1.8" dy="1.8" layer="1"/>
<text x="-2.54" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.651" y1="-1.3081" x2="-0.9009" y2="1.2918" layer="51"/>
<rectangle x1="0.9144" y1="-1.3081" x2="1.6645" y2="1.2918" layer="51"/>
<rectangle x1="-0.3" y1="-0.8001" x2="0.3" y2="0.8001" layer="35"/>
</package>
<package name="R2010">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="-1.662" y1="1.245" x2="1.662" y2="1.245" width="0.1524" layer="51"/>
<wire x1="-1.637" y1="-1.245" x2="1.687" y2="-1.245" width="0.1524" layer="51"/>
<wire x1="-3.473" y1="1.483" x2="3.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="3.473" y1="1.483" x2="3.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="3.473" y1="-1.483" x2="-3.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-3.473" y1="-1.483" x2="-3.473" y2="1.483" width="0.0508" layer="39"/>
<smd name="1" x="-2.2" y="0" dx="1.8" dy="2.7" layer="1"/>
<smd name="2" x="2.2" y="0" dx="1.8" dy="2.7" layer="1"/>
<text x="-3.175" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-3.175" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-2.4892" y1="-1.3208" x2="-1.6393" y2="1.3292" layer="51"/>
<rectangle x1="1.651" y1="-1.3208" x2="2.5009" y2="1.3292" layer="51"/>
</package>
<package name="R2010W">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
wave soldering</description>
<wire x1="-1.662" y1="1.245" x2="1.662" y2="1.245" width="0.1524" layer="51"/>
<wire x1="-1.637" y1="-1.245" x2="1.687" y2="-1.245" width="0.1524" layer="51"/>
<wire x1="-3.473" y1="1.483" x2="3.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="3.473" y1="1.483" x2="3.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="3.473" y1="-1.483" x2="-3.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-3.473" y1="-1.483" x2="-3.473" y2="1.483" width="0.0508" layer="39"/>
<smd name="1" x="-2.311" y="0" dx="2" dy="1.8" layer="1"/>
<smd name="2" x="2.311" y="0" dx="2" dy="1.8" layer="1"/>
<text x="-2.54" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-2.4892" y1="-1.3208" x2="-1.6393" y2="1.3292" layer="51"/>
<rectangle x1="1.651" y1="-1.3208" x2="2.5009" y2="1.3292" layer="51"/>
</package>
<package name="R2012">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="-0.41" y1="0.635" x2="0.41" y2="0.635" width="0.1524" layer="51"/>
<wire x1="-0.41" y1="-0.635" x2="0.41" y2="-0.635" width="0.1524" layer="51"/>
<wire x1="-1.973" y1="0.983" x2="1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="0.983" x2="1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="-0.983" x2="-1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.973" y1="-0.983" x2="-1.973" y2="0.983" width="0.0508" layer="39"/>
<smd name="1" x="-0.85" y="0" dx="1.3" dy="1.5" layer="1"/>
<smd name="2" x="0.85" y="0" dx="1.3" dy="1.5" layer="1"/>
<text x="-0.635" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="0.4064" y1="-0.6985" x2="1.0564" y2="0.7015" layer="51"/>
<rectangle x1="-1.0668" y1="-0.6985" x2="-0.4168" y2="0.7015" layer="51"/>
<rectangle x1="-0.1001" y1="-0.5999" x2="0.1001" y2="0.5999" layer="35"/>
</package>
<package name="R2012W">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
wave soldering</description>
<wire x1="-0.41" y1="0.635" x2="0.41" y2="0.635" width="0.1524" layer="51"/>
<wire x1="-0.41" y1="-0.635" x2="0.41" y2="-0.635" width="0.1524" layer="51"/>
<wire x1="-1.973" y1="0.983" x2="1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="0.983" x2="1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="-0.983" x2="-1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.973" y1="-0.983" x2="-1.973" y2="0.983" width="0.0508" layer="39"/>
<smd name="1" x="-0.94" y="0" dx="1.5" dy="1" layer="1"/>
<smd name="2" x="0.94" y="0" dx="1.5" dy="1" layer="1"/>
<text x="-0.635" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="0.4064" y1="-0.6985" x2="1.0564" y2="0.7015" layer="51"/>
<rectangle x1="-1.0668" y1="-0.6985" x2="-0.4168" y2="0.7015" layer="51"/>
<rectangle x1="-0.1001" y1="-0.5999" x2="0.1001" y2="0.5999" layer="35"/>
</package>
<package name="R2512">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="-2.362" y1="1.473" x2="2.387" y2="1.473" width="0.1524" layer="51"/>
<wire x1="-2.362" y1="-1.473" x2="2.387" y2="-1.473" width="0.1524" layer="51"/>
<wire x1="-3.973" y1="1.983" x2="3.973" y2="1.983" width="0.0508" layer="39"/>
<wire x1="3.973" y1="1.983" x2="3.973" y2="-1.983" width="0.0508" layer="39"/>
<wire x1="3.973" y1="-1.983" x2="-3.973" y2="-1.983" width="0.0508" layer="39"/>
<wire x1="-3.973" y1="-1.983" x2="-3.973" y2="1.983" width="0.0508" layer="39"/>
<smd name="1" x="-2.8" y="0" dx="1.8" dy="3.2" layer="1"/>
<smd name="2" x="2.8" y="0" dx="1.8" dy="3.2" layer="1"/>
<text x="-2.54" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-3.2004" y1="-1.5494" x2="-2.3505" y2="1.5507" layer="51"/>
<rectangle x1="2.3622" y1="-1.5494" x2="3.2121" y2="1.5507" layer="51"/>
<rectangle x1="-0.5001" y1="-1" x2="0.5001" y2="1" layer="35"/>
</package>
<package name="R2512W">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
wave soldering</description>
<wire x1="-2.362" y1="1.473" x2="2.387" y2="1.473" width="0.1524" layer="51"/>
<wire x1="-2.362" y1="-1.473" x2="2.387" y2="-1.473" width="0.1524" layer="51"/>
<wire x1="-3.973" y1="1.983" x2="3.973" y2="1.983" width="0.0508" layer="39"/>
<wire x1="3.973" y1="1.983" x2="3.973" y2="-1.983" width="0.0508" layer="39"/>
<wire x1="3.973" y1="-1.983" x2="-3.973" y2="-1.983" width="0.0508" layer="39"/>
<wire x1="-3.973" y1="-1.983" x2="-3.973" y2="1.983" width="0.0508" layer="39"/>
<smd name="1" x="-2.896" y="0" dx="2" dy="2.1" layer="1"/>
<smd name="2" x="2.896" y="0" dx="2" dy="2.1" layer="1"/>
<text x="-1.905" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.905" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-3.2004" y1="-1.5494" x2="-2.3505" y2="1.5507" layer="51"/>
<rectangle x1="2.3622" y1="-1.5494" x2="3.2121" y2="1.5507" layer="51"/>
<rectangle x1="-0.5001" y1="-1" x2="0.5001" y2="1" layer="35"/>
</package>
<package name="R3216">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="-0.913" y1="0.8" x2="0.888" y2="0.8" width="0.1524" layer="51"/>
<wire x1="-0.913" y1="-0.8" x2="0.888" y2="-0.8" width="0.1524" layer="51"/>
<wire x1="-2.473" y1="0.983" x2="2.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="0.983" x2="2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-0.983" x2="-2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-0.983" x2="-2.473" y2="0.983" width="0.0508" layer="39"/>
<smd name="1" x="-1.4" y="0" dx="1.6" dy="1.8" layer="1"/>
<smd name="2" x="1.4" y="0" dx="1.6" dy="1.8" layer="1"/>
<text x="-1.905" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.905" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.651" y1="-0.8763" x2="-0.9009" y2="0.8738" layer="51"/>
<rectangle x1="0.889" y1="-0.8763" x2="1.6391" y2="0.8738" layer="51"/>
<rectangle x1="-0.3" y1="-0.7" x2="0.3" y2="0.7" layer="35"/>
</package>
<package name="R3216W">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
wave soldering</description>
<wire x1="-0.913" y1="0.8" x2="0.888" y2="0.8" width="0.1524" layer="51"/>
<wire x1="-0.913" y1="-0.8" x2="0.888" y2="-0.8" width="0.1524" layer="51"/>
<wire x1="-2.473" y1="0.983" x2="2.473" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="0.983" x2="2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-0.983" x2="-2.473" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-0.983" x2="-2.473" y2="0.983" width="0.0508" layer="39"/>
<smd name="1" x="-1.499" y="0" dx="1.8" dy="1.2" layer="1"/>
<smd name="2" x="1.499" y="0" dx="1.8" dy="1.2" layer="1"/>
<text x="-1.905" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.905" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.651" y1="-0.8763" x2="-0.9009" y2="0.8738" layer="51"/>
<rectangle x1="0.889" y1="-0.8763" x2="1.6391" y2="0.8738" layer="51"/>
<rectangle x1="-0.3" y1="-0.7" x2="0.3" y2="0.7" layer="35"/>
</package>
<package name="R3225">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="-0.913" y1="1.219" x2="0.939" y2="1.219" width="0.1524" layer="51"/>
<wire x1="-0.913" y1="-1.219" x2="0.939" y2="-1.219" width="0.1524" layer="51"/>
<wire x1="-2.473" y1="1.483" x2="2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="1.483" x2="2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-1.483" x2="-2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-1.483" x2="-2.473" y2="1.483" width="0.0508" layer="39"/>
<smd name="1" x="-1.4" y="0" dx="1.6" dy="2.7" layer="1"/>
<smd name="2" x="1.4" y="0" dx="1.6" dy="2.7" layer="1"/>
<text x="-2.54" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.651" y1="-1.3081" x2="-0.9009" y2="1.2918" layer="51"/>
<rectangle x1="0.9144" y1="-1.3081" x2="1.6645" y2="1.2918" layer="51"/>
<rectangle x1="-0.3" y1="-1" x2="0.3" y2="1" layer="35"/>
</package>
<package name="R3225W">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
wave soldering</description>
<wire x1="-0.913" y1="1.219" x2="0.939" y2="1.219" width="0.1524" layer="51"/>
<wire x1="-0.913" y1="-1.219" x2="0.939" y2="-1.219" width="0.1524" layer="51"/>
<wire x1="-2.473" y1="1.483" x2="2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="1.483" x2="2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-1.483" x2="-2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-1.483" x2="-2.473" y2="1.483" width="0.0508" layer="39"/>
<smd name="1" x="-1.499" y="0" dx="1.8" dy="1.8" layer="1"/>
<smd name="2" x="1.499" y="0" dx="1.8" dy="1.8" layer="1"/>
<text x="-1.905" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.905" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.651" y1="-1.3081" x2="-0.9009" y2="1.2918" layer="51"/>
<rectangle x1="0.9144" y1="-1.3081" x2="1.6645" y2="1.2918" layer="51"/>
<rectangle x1="-0.3" y1="-1" x2="0.3" y2="1" layer="35"/>
</package>
<package name="R5025">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;</description>
<wire x1="-1.662" y1="1.245" x2="1.662" y2="1.245" width="0.1524" layer="51"/>
<wire x1="-1.637" y1="-1.245" x2="1.687" y2="-1.245" width="0.1524" layer="51"/>
<wire x1="-3.473" y1="1.483" x2="3.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="3.473" y1="1.483" x2="3.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="3.473" y1="-1.483" x2="-3.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-3.473" y1="-1.483" x2="-3.473" y2="1.483" width="0.0508" layer="39"/>
<smd name="1" x="-2.2" y="0" dx="1.8" dy="2.7" layer="1"/>
<smd name="2" x="2.2" y="0" dx="1.8" dy="2.7" layer="1"/>
<text x="-3.175" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-3.175" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-2.4892" y1="-1.3208" x2="-1.6393" y2="1.3292" layer="51"/>
<rectangle x1="1.651" y1="-1.3208" x2="2.5009" y2="1.3292" layer="51"/>
<rectangle x1="-0.5001" y1="-1" x2="0.5001" y2="1" layer="35"/>
</package>
<package name="R5025W">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
wave soldering</description>
<wire x1="-1.662" y1="1.245" x2="1.662" y2="1.245" width="0.1524" layer="51"/>
<wire x1="-1.637" y1="-1.245" x2="1.687" y2="-1.245" width="0.1524" layer="51"/>
<wire x1="-3.473" y1="1.483" x2="3.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="3.473" y1="1.483" x2="3.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="3.473" y1="-1.483" x2="-3.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-3.473" y1="-1.483" x2="-3.473" y2="1.483" width="0.0508" layer="39"/>
<smd name="1" x="-2.311" y="0" dx="2" dy="1.8" layer="1"/>
<smd name="2" x="2.311" y="0" dx="2" dy="1.8" layer="1"/>
<text x="-3.175" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-3.175" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-2.4892" y1="-1.3208" x2="-1.6393" y2="1.3292" layer="51"/>
<rectangle x1="1.651" y1="-1.3208" x2="2.5009" y2="1.3292" layer="51"/>
<rectangle x1="-0.5001" y1="-1" x2="0.5001" y2="1" layer="35"/>
</package>
<package name="R6332">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
Source: http://download.siliconexpert.com/pdfs/2005/02/24/Semi_Ap/2/VSH/Resistor/dcrcwfre.pdf</description>
<wire x1="-2.362" y1="1.473" x2="2.387" y2="1.473" width="0.1524" layer="51"/>
<wire x1="-2.362" y1="-1.473" x2="2.387" y2="-1.473" width="0.1524" layer="51"/>
<wire x1="-3.973" y1="1.983" x2="3.973" y2="1.983" width="0.0508" layer="39"/>
<wire x1="3.973" y1="1.983" x2="3.973" y2="-1.983" width="0.0508" layer="39"/>
<wire x1="3.973" y1="-1.983" x2="-3.973" y2="-1.983" width="0.0508" layer="39"/>
<wire x1="-3.973" y1="-1.983" x2="-3.973" y2="1.983" width="0.0508" layer="39"/>
<smd name="1" x="-3.1" y="0" dx="1" dy="3.2" layer="1"/>
<smd name="2" x="3.1" y="0" dx="1" dy="3.2" layer="1"/>
<text x="-2.54" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-3.2004" y1="-1.5494" x2="-2.3505" y2="1.5507" layer="51"/>
<rectangle x1="2.3622" y1="-1.5494" x2="3.2121" y2="1.5507" layer="51"/>
<rectangle x1="-0.5001" y1="-1" x2="0.5001" y2="1" layer="35"/>
</package>
<package name="R6332W">
<description>&lt;b&gt;RESISTOR&lt;/b&gt; wave soldering&lt;p&gt;
Source: http://download.siliconexpert.com/pdfs/2005/02/24/Semi_Ap/2/VSH/Resistor/dcrcwfre.pdf</description>
<wire x1="-2.362" y1="1.473" x2="2.387" y2="1.473" width="0.1524" layer="51"/>
<wire x1="-2.362" y1="-1.473" x2="2.387" y2="-1.473" width="0.1524" layer="51"/>
<wire x1="-3.973" y1="1.983" x2="3.973" y2="1.983" width="0.0508" layer="39"/>
<wire x1="3.973" y1="1.983" x2="3.973" y2="-1.983" width="0.0508" layer="39"/>
<wire x1="3.973" y1="-1.983" x2="-3.973" y2="-1.983" width="0.0508" layer="39"/>
<wire x1="-3.973" y1="-1.983" x2="-3.973" y2="1.983" width="0.0508" layer="39"/>
<smd name="1" x="-3.196" y="0" dx="1.2" dy="3.2" layer="1"/>
<smd name="2" x="3.196" y="0" dx="1.2" dy="3.2" layer="1"/>
<text x="-2.54" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-3.2004" y1="-1.5494" x2="-2.3505" y2="1.5507" layer="51"/>
<rectangle x1="2.3622" y1="-1.5494" x2="3.2121" y2="1.5507" layer="51"/>
<rectangle x1="-0.5001" y1="-1" x2="0.5001" y2="1" layer="35"/>
</package>
<package name="M0805">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
MELF 0.10 W</description>
<wire x1="-1.973" y1="0.983" x2="1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="-0.983" x2="-1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.973" y1="-0.983" x2="-1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="0.983" x2="1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="0.7112" y1="0.635" x2="-0.7112" y2="0.635" width="0.1524" layer="51"/>
<wire x1="0.7112" y1="-0.635" x2="-0.7112" y2="-0.635" width="0.1524" layer="51"/>
<smd name="1" x="-0.95" y="0" dx="1.3" dy="1.6" layer="1"/>
<smd name="2" x="0.95" y="0" dx="1.3" dy="1.6" layer="1"/>
<text x="-1.27" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.0414" y1="-0.7112" x2="-0.6858" y2="0.7112" layer="51"/>
<rectangle x1="0.6858" y1="-0.7112" x2="1.0414" y2="0.7112" layer="51"/>
<rectangle x1="-0.1999" y1="-0.5999" x2="0.1999" y2="0.5999" layer="35"/>
</package>
<package name="M1206">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
MELF 0.25 W</description>
<wire x1="-2.473" y1="1.483" x2="2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-1.483" x2="-2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-1.483" x2="-2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="1.483" x2="2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="1.143" y1="0.8382" x2="-1.143" y2="0.8382" width="0.1524" layer="51"/>
<wire x1="1.143" y1="-0.8382" x2="-1.143" y2="-0.8382" width="0.1524" layer="51"/>
<smd name="1" x="-1.4" y="0" dx="1.6" dy="2" layer="1"/>
<smd name="2" x="1.4" y="0" dx="1.6" dy="2" layer="1"/>
<text x="-1.27" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.7018" y1="-0.9144" x2="-1.1176" y2="0.9144" layer="51"/>
<rectangle x1="1.1176" y1="-0.9144" x2="1.7018" y2="0.9144" layer="51"/>
<rectangle x1="-0.3" y1="-0.8001" x2="0.3" y2="0.8001" layer="35"/>
</package>
<package name="M1406">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
MELF 0.12 W</description>
<wire x1="-2.973" y1="0.983" x2="2.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.973" y1="-0.983" x2="-2.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-2.973" y1="-0.983" x2="-2.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.973" y1="0.983" x2="2.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.3208" y1="0.762" x2="-1.3208" y2="0.762" width="0.1524" layer="51"/>
<wire x1="1.3208" y1="-0.762" x2="-1.3208" y2="-0.762" width="0.1524" layer="51"/>
<smd name="1" x="-1.7" y="0" dx="1.4" dy="1.8" layer="1"/>
<smd name="2" x="1.7" y="0" dx="1.4" dy="1.8" layer="1"/>
<text x="-1.27" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.8542" y1="-0.8382" x2="-1.2954" y2="0.8382" layer="51"/>
<rectangle x1="1.2954" y1="-0.8382" x2="1.8542" y2="0.8382" layer="51"/>
<rectangle x1="-0.3" y1="-0.7" x2="0.3" y2="0.7" layer="35"/>
</package>
<package name="M2012">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
MELF 0.10 W</description>
<wire x1="-1.973" y1="0.983" x2="1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="-0.983" x2="-1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-1.973" y1="-0.983" x2="-1.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="1.973" y1="0.983" x2="1.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="0.7112" y1="0.635" x2="-0.7112" y2="0.635" width="0.1524" layer="51"/>
<wire x1="0.7112" y1="-0.635" x2="-0.7112" y2="-0.635" width="0.1524" layer="51"/>
<smd name="1" x="-0.95" y="0" dx="1.3" dy="1.6" layer="1"/>
<smd name="2" x="0.95" y="0" dx="1.3" dy="1.6" layer="1"/>
<text x="-1.27" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.0414" y1="-0.7112" x2="-0.6858" y2="0.7112" layer="51"/>
<rectangle x1="0.6858" y1="-0.7112" x2="1.0414" y2="0.7112" layer="51"/>
<rectangle x1="-0.1999" y1="-0.5999" x2="0.1999" y2="0.5999" layer="35"/>
</package>
<package name="M2309">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
MELF 0.25 W</description>
<wire x1="-4.473" y1="1.483" x2="4.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="4.473" y1="-1.483" x2="-4.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-4.473" y1="-1.483" x2="-4.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="4.473" y1="1.483" x2="4.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="2.413" y1="1.1684" x2="-2.4384" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="2.413" y1="-1.1684" x2="-2.413" y2="-1.1684" width="0.1524" layer="51"/>
<smd name="1" x="-2.85" y="0" dx="1.5" dy="2.6" layer="1"/>
<smd name="2" x="2.85" y="0" dx="1.5" dy="2.6" layer="1"/>
<text x="-1.905" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-3.048" y1="-1.2446" x2="-2.3876" y2="1.2446" layer="51"/>
<rectangle x1="2.3876" y1="-1.2446" x2="3.048" y2="1.2446" layer="51"/>
<rectangle x1="-0.5001" y1="-1" x2="0.5001" y2="1" layer="35"/>
</package>
<package name="M3216">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
MELF 0.25 W</description>
<wire x1="-2.473" y1="1.483" x2="2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="-1.483" x2="-2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-2.473" y1="-1.483" x2="-2.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="2.473" y1="1.483" x2="2.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="1.143" y1="0.8382" x2="-1.143" y2="0.8382" width="0.1524" layer="51"/>
<wire x1="1.143" y1="-0.8382" x2="-1.143" y2="-0.8382" width="0.1524" layer="51"/>
<smd name="1" x="-1.4" y="0" dx="1.6" dy="2" layer="1"/>
<smd name="2" x="1.4" y="0" dx="1.6" dy="2" layer="1"/>
<text x="-1.27" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.7018" y1="-0.9144" x2="-1.1176" y2="0.9144" layer="51"/>
<rectangle x1="1.1176" y1="-0.9144" x2="1.7018" y2="0.9144" layer="51"/>
<rectangle x1="-0.3" y1="-0.8001" x2="0.3" y2="0.8001" layer="35"/>
</package>
<package name="M3516">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
MELF 0.12 W</description>
<wire x1="-2.973" y1="0.983" x2="2.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.973" y1="-0.983" x2="-2.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="-2.973" y1="-0.983" x2="-2.973" y2="0.983" width="0.0508" layer="39"/>
<wire x1="2.973" y1="0.983" x2="2.973" y2="-0.983" width="0.0508" layer="39"/>
<wire x1="1.3208" y1="0.762" x2="-1.3208" y2="0.762" width="0.1524" layer="51"/>
<wire x1="1.3208" y1="-0.762" x2="-1.3208" y2="-0.762" width="0.1524" layer="51"/>
<smd name="1" x="-1.7" y="0" dx="1.4" dy="1.8" layer="1"/>
<smd name="2" x="1.7" y="0" dx="1.4" dy="1.8" layer="1"/>
<text x="-1.27" y="1.27" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.8542" y1="-0.8382" x2="-1.2954" y2="0.8382" layer="51"/>
<rectangle x1="1.2954" y1="-0.8382" x2="1.8542" y2="0.8382" layer="51"/>
<rectangle x1="-0.4001" y1="-0.7" x2="0.4001" y2="0.7" layer="35"/>
</package>
<package name="M5923">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
MELF 0.25 W</description>
<wire x1="-4.473" y1="1.483" x2="4.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="4.473" y1="-1.483" x2="-4.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="-4.473" y1="-1.483" x2="-4.473" y2="1.483" width="0.0508" layer="39"/>
<wire x1="4.473" y1="1.483" x2="4.473" y2="-1.483" width="0.0508" layer="39"/>
<wire x1="2.413" y1="1.1684" x2="-2.4384" y2="1.1684" width="0.1524" layer="51"/>
<wire x1="2.413" y1="-1.1684" x2="-2.413" y2="-1.1684" width="0.1524" layer="51"/>
<smd name="1" x="-2.85" y="0" dx="1.5" dy="2.6" layer="1"/>
<smd name="2" x="2.85" y="0" dx="1.5" dy="2.6" layer="1"/>
<text x="-1.905" y="1.905" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-3.048" y1="-1.2446" x2="-2.3876" y2="1.2446" layer="51"/>
<rectangle x1="2.3876" y1="-1.2446" x2="3.048" y2="1.2446" layer="51"/>
<rectangle x1="-0.5001" y1="-1" x2="0.5001" y2="1" layer="35"/>
</package>
<package name="0204/5">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0204, grid 5 mm</description>
<wire x1="2.54" y1="0" x2="2.032" y2="0" width="0.508" layer="51"/>
<wire x1="-2.54" y1="0" x2="-2.032" y2="0" width="0.508" layer="51"/>
<wire x1="-1.778" y1="0.635" x2="-1.524" y2="0.889" width="0.1524" layer="21" curve="-90"/>
<wire x1="-1.778" y1="-0.635" x2="-1.524" y2="-0.889" width="0.1524" layer="21" curve="90"/>
<wire x1="1.524" y1="-0.889" x2="1.778" y2="-0.635" width="0.1524" layer="21" curve="90"/>
<wire x1="1.524" y1="0.889" x2="1.778" y2="0.635" width="0.1524" layer="21" curve="-90"/>
<wire x1="-1.778" y1="-0.635" x2="-1.778" y2="0.635" width="0.1524" layer="51"/>
<wire x1="-1.524" y1="0.889" x2="-1.27" y2="0.889" width="0.1524" layer="21"/>
<wire x1="-1.143" y1="0.762" x2="-1.27" y2="0.889" width="0.1524" layer="21"/>
<wire x1="-1.524" y1="-0.889" x2="-1.27" y2="-0.889" width="0.1524" layer="21"/>
<wire x1="-1.143" y1="-0.762" x2="-1.27" y2="-0.889" width="0.1524" layer="21"/>
<wire x1="1.143" y1="0.762" x2="1.27" y2="0.889" width="0.1524" layer="21"/>
<wire x1="1.143" y1="0.762" x2="-1.143" y2="0.762" width="0.1524" layer="21"/>
<wire x1="1.143" y1="-0.762" x2="1.27" y2="-0.889" width="0.1524" layer="21"/>
<wire x1="1.143" y1="-0.762" x2="-1.143" y2="-0.762" width="0.1524" layer="21"/>
<wire x1="1.524" y1="0.889" x2="1.27" y2="0.889" width="0.1524" layer="21"/>
<wire x1="1.524" y1="-0.889" x2="1.27" y2="-0.889" width="0.1524" layer="21"/>
<wire x1="1.778" y1="-0.635" x2="1.778" y2="0.635" width="0.1524" layer="51"/>
<pad name="1" x="-2.54" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.0066" y="1.1684" size="0.9906" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.1336" y="-2.3114" size="0.9906" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-2.032" y1="-0.254" x2="-1.778" y2="0.254" layer="51"/>
<rectangle x1="1.778" y1="-0.254" x2="2.032" y2="0.254" layer="51"/>
</package>
<package name="0204/7">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0204, grid 7.5 mm</description>
<wire x1="3.81" y1="0" x2="2.921" y2="0" width="0.508" layer="51"/>
<wire x1="-3.81" y1="0" x2="-2.921" y2="0" width="0.508" layer="51"/>
<wire x1="-2.54" y1="0.762" x2="-2.286" y2="1.016" width="0.1524" layer="21" curve="-90"/>
<wire x1="-2.54" y1="-0.762" x2="-2.286" y2="-1.016" width="0.1524" layer="21" curve="90"/>
<wire x1="2.286" y1="-1.016" x2="2.54" y2="-0.762" width="0.1524" layer="21" curve="90"/>
<wire x1="2.286" y1="1.016" x2="2.54" y2="0.762" width="0.1524" layer="21" curve="-90"/>
<wire x1="-2.54" y1="-0.762" x2="-2.54" y2="0.762" width="0.1524" layer="21"/>
<wire x1="-2.286" y1="1.016" x2="-1.905" y2="1.016" width="0.1524" layer="21"/>
<wire x1="-1.778" y1="0.889" x2="-1.905" y2="1.016" width="0.1524" layer="21"/>
<wire x1="-2.286" y1="-1.016" x2="-1.905" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="-1.778" y1="-0.889" x2="-1.905" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="1.778" y1="0.889" x2="1.905" y2="1.016" width="0.1524" layer="21"/>
<wire x1="1.778" y1="0.889" x2="-1.778" y2="0.889" width="0.1524" layer="21"/>
<wire x1="1.778" y1="-0.889" x2="1.905" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="1.778" y1="-0.889" x2="-1.778" y2="-0.889" width="0.1524" layer="21"/>
<wire x1="2.286" y1="1.016" x2="1.905" y2="1.016" width="0.1524" layer="21"/>
<wire x1="2.286" y1="-1.016" x2="1.905" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="2.54" y1="-0.762" x2="2.54" y2="0.762" width="0.1524" layer="21"/>
<pad name="1" x="-3.81" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="3.81" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.54" y="1.2954" size="0.9906" layer="25" ratio="10">&gt;NAME</text>
<text x="-1.6256" y="-0.4826" size="0.9906" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="2.54" y1="-0.254" x2="2.921" y2="0.254" layer="21"/>
<rectangle x1="-2.921" y1="-0.254" x2="-2.54" y2="0.254" layer="21"/>
</package>
<package name="0204V">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0204, grid 2.5 mm</description>
<wire x1="-1.27" y1="0" x2="1.27" y2="0" width="0.508" layer="51"/>
<wire x1="-0.127" y1="0" x2="0.127" y2="0" width="0.508" layer="21"/>
<circle x="-1.27" y="0" radius="0.889" width="0.1524" layer="51"/>
<circle x="-1.27" y="0" radius="0.635" width="0.0508" layer="51"/>
<pad name="1" x="-1.27" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.1336" y="1.1684" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.1336" y="-2.3114" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="0207/10">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0207, grid 10 mm</description>
<wire x1="5.08" y1="0" x2="4.064" y2="0" width="0.6096" layer="51"/>
<wire x1="-5.08" y1="0" x2="-4.064" y2="0" width="0.6096" layer="51"/>
<wire x1="-3.175" y1="0.889" x2="-2.921" y2="1.143" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-2.921" y2="-1.143" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="-1.143" x2="3.175" y2="-0.889" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="1.143" x2="3.175" y2="0.889" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-3.175" y2="0.889" width="0.1524" layer="21"/>
<wire x1="-2.921" y1="1.143" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="1.016" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.921" y1="-1.143" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="-1.016" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="-2.413" y2="1.016" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="-2.413" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="2.921" y1="1.143" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.921" y1="-1.143" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="3.175" y1="-0.889" x2="3.175" y2="0.889" width="0.1524" layer="21"/>
<pad name="1" x="-5.08" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="5.08" y="0" drill="0.8128" shape="octagon"/>
<text x="-3.048" y="1.524" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.2606" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="3.175" y1="-0.3048" x2="4.0386" y2="0.3048" layer="21"/>
<rectangle x1="-4.0386" y1="-0.3048" x2="-3.175" y2="0.3048" layer="21"/>
</package>
<package name="0207/12">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0207, grid 12 mm</description>
<wire x1="6.35" y1="0" x2="5.334" y2="0" width="0.6096" layer="51"/>
<wire x1="-6.35" y1="0" x2="-5.334" y2="0" width="0.6096" layer="51"/>
<wire x1="-3.175" y1="0.889" x2="-2.921" y2="1.143" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-2.921" y2="-1.143" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="-1.143" x2="3.175" y2="-0.889" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="1.143" x2="3.175" y2="0.889" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-3.175" y2="0.889" width="0.1524" layer="21"/>
<wire x1="-2.921" y1="1.143" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="1.016" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.921" y1="-1.143" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="-1.016" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="-2.413" y2="1.016" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="-2.413" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="2.921" y1="1.143" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.921" y1="-1.143" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="3.175" y1="-0.889" x2="3.175" y2="0.889" width="0.1524" layer="21"/>
<wire x1="4.445" y1="0" x2="4.064" y2="0" width="0.6096" layer="21"/>
<wire x1="-4.445" y1="0" x2="-4.064" y2="0" width="0.6096" layer="21"/>
<pad name="1" x="-6.35" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="6.35" y="0" drill="0.8128" shape="octagon"/>
<text x="-3.175" y="1.397" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.286" y="-0.6858" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="3.175" y1="-0.3048" x2="4.0386" y2="0.3048" layer="21"/>
<rectangle x1="-4.0386" y1="-0.3048" x2="-3.175" y2="0.3048" layer="21"/>
<rectangle x1="4.445" y1="-0.3048" x2="5.3086" y2="0.3048" layer="21"/>
<rectangle x1="-5.3086" y1="-0.3048" x2="-4.445" y2="0.3048" layer="21"/>
</package>
<package name="0207/15">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0207, grid 15mm</description>
<wire x1="7.62" y1="0" x2="6.604" y2="0" width="0.6096" layer="51"/>
<wire x1="-7.62" y1="0" x2="-6.604" y2="0" width="0.6096" layer="51"/>
<wire x1="-3.175" y1="0.889" x2="-2.921" y2="1.143" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-2.921" y2="-1.143" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="-1.143" x2="3.175" y2="-0.889" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="1.143" x2="3.175" y2="0.889" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-3.175" y2="0.889" width="0.1524" layer="21"/>
<wire x1="-2.921" y1="1.143" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="1.016" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.921" y1="-1.143" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="-1.016" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="-2.413" y2="1.016" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="-2.413" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="2.921" y1="1.143" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.921" y1="-1.143" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="3.175" y1="-0.889" x2="3.175" y2="0.889" width="0.1524" layer="21"/>
<wire x1="5.715" y1="0" x2="4.064" y2="0" width="0.6096" layer="21"/>
<wire x1="-5.715" y1="0" x2="-4.064" y2="0" width="0.6096" layer="21"/>
<pad name="1" x="-7.62" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="7.62" y="0" drill="0.8128" shape="octagon"/>
<text x="-3.175" y="1.397" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.286" y="-0.6858" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="3.175" y1="-0.3048" x2="4.0386" y2="0.3048" layer="21"/>
<rectangle x1="-4.0386" y1="-0.3048" x2="-3.175" y2="0.3048" layer="21"/>
<rectangle x1="5.715" y1="-0.3048" x2="6.5786" y2="0.3048" layer="21"/>
<rectangle x1="-6.5786" y1="-0.3048" x2="-5.715" y2="0.3048" layer="21"/>
</package>
<package name="0207/2V">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0207, grid 2.5 mm</description>
<wire x1="-1.27" y1="0" x2="-0.381" y2="0" width="0.6096" layer="51"/>
<wire x1="-0.254" y1="0" x2="0.254" y2="0" width="0.6096" layer="21"/>
<wire x1="0.381" y1="0" x2="1.27" y2="0" width="0.6096" layer="51"/>
<circle x="-1.27" y="0" radius="1.27" width="0.1524" layer="21"/>
<circle x="-1.27" y="0" radius="1.016" width="0.1524" layer="51"/>
<pad name="1" x="-1.27" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.8128" shape="octagon"/>
<text x="-0.0508" y="1.016" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-0.0508" y="-2.2352" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="0207/5V">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0207, grid 5 mm</description>
<wire x1="-2.54" y1="0" x2="-0.889" y2="0" width="0.6096" layer="51"/>
<wire x1="-0.762" y1="0" x2="0.762" y2="0" width="0.6096" layer="21"/>
<wire x1="0.889" y1="0" x2="2.54" y2="0" width="0.6096" layer="51"/>
<circle x="-2.54" y="0" radius="1.27" width="0.1016" layer="21"/>
<circle x="-2.54" y="0" radius="1.016" width="0.1524" layer="51"/>
<pad name="1" x="-2.54" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="0.8128" shape="octagon"/>
<text x="-1.143" y="0.889" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-1.143" y="-2.159" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="0207/7">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0207, grid 7.5 mm</description>
<wire x1="-3.81" y1="0" x2="-3.429" y2="0" width="0.6096" layer="51"/>
<wire x1="-3.175" y1="0.889" x2="-2.921" y2="1.143" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-2.921" y2="-1.143" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="-1.143" x2="3.175" y2="-0.889" width="0.1524" layer="21" curve="90"/>
<wire x1="2.921" y1="1.143" x2="3.175" y2="0.889" width="0.1524" layer="21" curve="-90"/>
<wire x1="-3.175" y1="-0.889" x2="-3.175" y2="0.889" width="0.1524" layer="51"/>
<wire x1="-2.921" y1="1.143" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="1.016" x2="-2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="-2.921" y1="-1.143" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="-2.413" y1="-1.016" x2="-2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="1.016" x2="-2.413" y2="1.016" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="2.413" y1="-1.016" x2="-2.413" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="2.921" y1="1.143" x2="2.54" y2="1.143" width="0.1524" layer="21"/>
<wire x1="2.921" y1="-1.143" x2="2.54" y2="-1.143" width="0.1524" layer="21"/>
<wire x1="3.175" y1="-0.889" x2="3.175" y2="0.889" width="0.1524" layer="51"/>
<wire x1="3.429" y1="0" x2="3.81" y2="0" width="0.6096" layer="51"/>
<pad name="1" x="-3.81" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="3.81" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.54" y="1.397" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.286" y="-0.5588" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-3.429" y1="-0.3048" x2="-3.175" y2="0.3048" layer="51"/>
<rectangle x1="3.175" y1="-0.3048" x2="3.429" y2="0.3048" layer="51"/>
</package>
<package name="0309/10">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0309, grid 10mm</description>
<wire x1="-4.699" y1="0" x2="-5.08" y2="0" width="0.6096" layer="51"/>
<wire x1="-4.318" y1="1.27" x2="-4.064" y2="1.524" width="0.1524" layer="21" curve="-90"/>
<wire x1="-4.318" y1="-1.27" x2="-4.064" y2="-1.524" width="0.1524" layer="21" curve="90"/>
<wire x1="4.064" y1="-1.524" x2="4.318" y2="-1.27" width="0.1524" layer="21" curve="90"/>
<wire x1="4.064" y1="1.524" x2="4.318" y2="1.27" width="0.1524" layer="21" curve="-90"/>
<wire x1="-4.318" y1="-1.27" x2="-4.318" y2="1.27" width="0.1524" layer="51"/>
<wire x1="-4.064" y1="1.524" x2="-3.429" y2="1.524" width="0.1524" layer="21"/>
<wire x1="-3.302" y1="1.397" x2="-3.429" y2="1.524" width="0.1524" layer="21"/>
<wire x1="-4.064" y1="-1.524" x2="-3.429" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="-3.302" y1="-1.397" x2="-3.429" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="3.302" y1="1.397" x2="3.429" y2="1.524" width="0.1524" layer="21"/>
<wire x1="3.302" y1="1.397" x2="-3.302" y2="1.397" width="0.1524" layer="21"/>
<wire x1="3.302" y1="-1.397" x2="3.429" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="3.302" y1="-1.397" x2="-3.302" y2="-1.397" width="0.1524" layer="21"/>
<wire x1="4.064" y1="1.524" x2="3.429" y2="1.524" width="0.1524" layer="21"/>
<wire x1="4.064" y1="-1.524" x2="3.429" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="4.318" y1="-1.27" x2="4.318" y2="1.27" width="0.1524" layer="51"/>
<wire x1="5.08" y1="0" x2="4.699" y2="0" width="0.6096" layer="51"/>
<pad name="1" x="-5.08" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="5.08" y="0" drill="0.8128" shape="octagon"/>
<text x="-4.191" y="1.905" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.175" y="-0.6858" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-4.6228" y1="-0.3048" x2="-4.318" y2="0.3048" layer="51"/>
<rectangle x1="4.318" y1="-0.3048" x2="4.6228" y2="0.3048" layer="51"/>
</package>
<package name="0309/12">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0309, grid 12.5 mm</description>
<wire x1="6.35" y1="0" x2="5.08" y2="0" width="0.6096" layer="51"/>
<wire x1="-6.35" y1="0" x2="-5.08" y2="0" width="0.6096" layer="51"/>
<wire x1="-4.318" y1="1.27" x2="-4.064" y2="1.524" width="0.1524" layer="21" curve="-90"/>
<wire x1="-4.318" y1="-1.27" x2="-4.064" y2="-1.524" width="0.1524" layer="21" curve="90"/>
<wire x1="4.064" y1="-1.524" x2="4.318" y2="-1.27" width="0.1524" layer="21" curve="90"/>
<wire x1="4.064" y1="1.524" x2="4.318" y2="1.27" width="0.1524" layer="21" curve="-90"/>
<wire x1="-4.318" y1="-1.27" x2="-4.318" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-4.064" y1="1.524" x2="-3.429" y2="1.524" width="0.1524" layer="21"/>
<wire x1="-3.302" y1="1.397" x2="-3.429" y2="1.524" width="0.1524" layer="21"/>
<wire x1="-4.064" y1="-1.524" x2="-3.429" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="-3.302" y1="-1.397" x2="-3.429" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="3.302" y1="1.397" x2="3.429" y2="1.524" width="0.1524" layer="21"/>
<wire x1="3.302" y1="1.397" x2="-3.302" y2="1.397" width="0.1524" layer="21"/>
<wire x1="3.302" y1="-1.397" x2="3.429" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="3.302" y1="-1.397" x2="-3.302" y2="-1.397" width="0.1524" layer="21"/>
<wire x1="4.064" y1="1.524" x2="3.429" y2="1.524" width="0.1524" layer="21"/>
<wire x1="4.064" y1="-1.524" x2="3.429" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="4.318" y1="-1.27" x2="4.318" y2="1.27" width="0.1524" layer="21"/>
<pad name="1" x="-6.35" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="6.35" y="0" drill="0.8128" shape="octagon"/>
<text x="-4.191" y="1.905" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.175" y="-0.6858" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="4.318" y1="-0.3048" x2="5.1816" y2="0.3048" layer="21"/>
<rectangle x1="-5.1816" y1="-0.3048" x2="-4.318" y2="0.3048" layer="21"/>
</package>
<package name="0309V">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0309, grid 2.5 mm</description>
<wire x1="1.27" y1="0" x2="0.635" y2="0" width="0.6096" layer="51"/>
<wire x1="-0.635" y1="0" x2="-1.27" y2="0" width="0.6096" layer="51"/>
<circle x="-1.27" y="0" radius="1.524" width="0.1524" layer="21"/>
<circle x="-1.27" y="0" radius="0.762" width="0.1524" layer="51"/>
<pad name="1" x="-1.27" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.8128" shape="octagon"/>
<text x="0.254" y="1.016" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="0.254" y="-2.2098" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="0.254" y1="-0.3048" x2="0.5588" y2="0.3048" layer="51"/>
<rectangle x1="-0.635" y1="-0.3048" x2="-0.3302" y2="0.3048" layer="51"/>
<rectangle x1="-0.3302" y1="-0.3048" x2="0.254" y2="0.3048" layer="21"/>
</package>
<package name="0411/12">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0411, grid 12.5 mm</description>
<wire x1="6.35" y1="0" x2="5.461" y2="0" width="0.762" layer="51"/>
<wire x1="-6.35" y1="0" x2="-5.461" y2="0" width="0.762" layer="51"/>
<wire x1="5.08" y1="-1.651" x2="5.08" y2="1.651" width="0.1524" layer="21"/>
<wire x1="4.699" y1="2.032" x2="5.08" y2="1.651" width="0.1524" layer="21" curve="-90"/>
<wire x1="-5.08" y1="-1.651" x2="-4.699" y2="-2.032" width="0.1524" layer="21" curve="90"/>
<wire x1="4.699" y1="-2.032" x2="5.08" y2="-1.651" width="0.1524" layer="21" curve="90"/>
<wire x1="-5.08" y1="1.651" x2="-4.699" y2="2.032" width="0.1524" layer="21" curve="-90"/>
<wire x1="4.699" y1="2.032" x2="4.064" y2="2.032" width="0.1524" layer="21"/>
<wire x1="3.937" y1="1.905" x2="4.064" y2="2.032" width="0.1524" layer="21"/>
<wire x1="4.699" y1="-2.032" x2="4.064" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="3.937" y1="-1.905" x2="4.064" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="-3.937" y1="1.905" x2="-4.064" y2="2.032" width="0.1524" layer="21"/>
<wire x1="-3.937" y1="1.905" x2="3.937" y2="1.905" width="0.1524" layer="21"/>
<wire x1="-3.937" y1="-1.905" x2="-4.064" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="-3.937" y1="-1.905" x2="3.937" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="1.651" x2="-5.08" y2="-1.651" width="0.1524" layer="21"/>
<wire x1="-4.699" y1="2.032" x2="-4.064" y2="2.032" width="0.1524" layer="21"/>
<wire x1="-4.699" y1="-2.032" x2="-4.064" y2="-2.032" width="0.1524" layer="21"/>
<pad name="1" x="-6.35" y="0" drill="0.9144" shape="octagon"/>
<pad name="2" x="6.35" y="0" drill="0.9144" shape="octagon"/>
<text x="-5.08" y="2.413" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.5814" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-5.3594" y1="-0.381" x2="-5.08" y2="0.381" layer="21"/>
<rectangle x1="5.08" y1="-0.381" x2="5.3594" y2="0.381" layer="21"/>
</package>
<package name="0411/15">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0411, grid 15 mm</description>
<wire x1="5.08" y1="-1.651" x2="5.08" y2="1.651" width="0.1524" layer="21"/>
<wire x1="4.699" y1="2.032" x2="5.08" y2="1.651" width="0.1524" layer="21" curve="-90"/>
<wire x1="-5.08" y1="-1.651" x2="-4.699" y2="-2.032" width="0.1524" layer="21" curve="90"/>
<wire x1="4.699" y1="-2.032" x2="5.08" y2="-1.651" width="0.1524" layer="21" curve="90"/>
<wire x1="-5.08" y1="1.651" x2="-4.699" y2="2.032" width="0.1524" layer="21" curve="-90"/>
<wire x1="4.699" y1="2.032" x2="4.064" y2="2.032" width="0.1524" layer="21"/>
<wire x1="3.937" y1="1.905" x2="4.064" y2="2.032" width="0.1524" layer="21"/>
<wire x1="4.699" y1="-2.032" x2="4.064" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="3.937" y1="-1.905" x2="4.064" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="-3.937" y1="1.905" x2="-4.064" y2="2.032" width="0.1524" layer="21"/>
<wire x1="-3.937" y1="1.905" x2="3.937" y2="1.905" width="0.1524" layer="21"/>
<wire x1="-3.937" y1="-1.905" x2="-4.064" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="-3.937" y1="-1.905" x2="3.937" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="1.651" x2="-5.08" y2="-1.651" width="0.1524" layer="21"/>
<wire x1="-4.699" y1="2.032" x2="-4.064" y2="2.032" width="0.1524" layer="21"/>
<wire x1="-4.699" y1="-2.032" x2="-4.064" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="0" x2="-6.35" y2="0" width="0.762" layer="51"/>
<wire x1="6.35" y1="0" x2="7.62" y2="0" width="0.762" layer="51"/>
<pad name="1" x="-7.62" y="0" drill="0.9144" shape="octagon"/>
<pad name="2" x="7.62" y="0" drill="0.9144" shape="octagon"/>
<text x="-5.08" y="2.413" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.5814" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="5.08" y1="-0.381" x2="6.477" y2="0.381" layer="21"/>
<rectangle x1="-6.477" y1="-0.381" x2="-5.08" y2="0.381" layer="21"/>
</package>
<package name="0411V">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0411, grid 3.81 mm</description>
<wire x1="1.27" y1="0" x2="0.3048" y2="0" width="0.762" layer="51"/>
<wire x1="-1.5748" y1="0" x2="-2.54" y2="0" width="0.762" layer="51"/>
<circle x="-2.54" y="0" radius="2.032" width="0.1524" layer="21"/>
<circle x="-2.54" y="0" radius="1.016" width="0.1524" layer="51"/>
<pad name="1" x="-2.54" y="0" drill="0.9144" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.9144" shape="octagon"/>
<text x="-0.508" y="1.143" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-0.5334" y="-2.413" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-1.4732" y1="-0.381" x2="0.2032" y2="0.381" layer="21"/>
</package>
<package name="0414/15">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0414, grid 15 mm</description>
<wire x1="7.62" y1="0" x2="6.604" y2="0" width="0.8128" layer="51"/>
<wire x1="-7.62" y1="0" x2="-6.604" y2="0" width="0.8128" layer="51"/>
<wire x1="-6.096" y1="1.905" x2="-5.842" y2="2.159" width="0.1524" layer="21" curve="-90"/>
<wire x1="-6.096" y1="-1.905" x2="-5.842" y2="-2.159" width="0.1524" layer="21" curve="90"/>
<wire x1="5.842" y1="-2.159" x2="6.096" y2="-1.905" width="0.1524" layer="21" curve="90"/>
<wire x1="5.842" y1="2.159" x2="6.096" y2="1.905" width="0.1524" layer="21" curve="-90"/>
<wire x1="-6.096" y1="-1.905" x2="-6.096" y2="1.905" width="0.1524" layer="21"/>
<wire x1="-5.842" y1="2.159" x2="-4.953" y2="2.159" width="0.1524" layer="21"/>
<wire x1="-4.826" y1="2.032" x2="-4.953" y2="2.159" width="0.1524" layer="21"/>
<wire x1="-5.842" y1="-2.159" x2="-4.953" y2="-2.159" width="0.1524" layer="21"/>
<wire x1="-4.826" y1="-2.032" x2="-4.953" y2="-2.159" width="0.1524" layer="21"/>
<wire x1="4.826" y1="2.032" x2="4.953" y2="2.159" width="0.1524" layer="21"/>
<wire x1="4.826" y1="2.032" x2="-4.826" y2="2.032" width="0.1524" layer="21"/>
<wire x1="4.826" y1="-2.032" x2="4.953" y2="-2.159" width="0.1524" layer="21"/>
<wire x1="4.826" y1="-2.032" x2="-4.826" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="5.842" y1="2.159" x2="4.953" y2="2.159" width="0.1524" layer="21"/>
<wire x1="5.842" y1="-2.159" x2="4.953" y2="-2.159" width="0.1524" layer="21"/>
<wire x1="6.096" y1="-1.905" x2="6.096" y2="1.905" width="0.1524" layer="21"/>
<pad name="1" x="-7.62" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="7.62" y="0" drill="1.016" shape="octagon"/>
<text x="-6.096" y="2.5654" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-4.318" y="-0.5842" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="6.096" y1="-0.4064" x2="6.5024" y2="0.4064" layer="21"/>
<rectangle x1="-6.5024" y1="-0.4064" x2="-6.096" y2="0.4064" layer="21"/>
</package>
<package name="0414V">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0414, grid 5 mm</description>
<wire x1="2.54" y1="0" x2="1.397" y2="0" width="0.8128" layer="51"/>
<wire x1="-2.54" y1="0" x2="-1.397" y2="0" width="0.8128" layer="51"/>
<circle x="-2.54" y="0" radius="2.159" width="0.1524" layer="21"/>
<circle x="-2.54" y="0" radius="1.143" width="0.1524" layer="51"/>
<pad name="1" x="-2.54" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="1.016" shape="octagon"/>
<text x="-0.381" y="1.1684" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-0.381" y="-2.3622" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-1.2954" y1="-0.4064" x2="1.2954" y2="0.4064" layer="21"/>
</package>
<package name="0617/17">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0617, grid 17.5 mm</description>
<wire x1="-8.89" y1="0" x2="-8.636" y2="0" width="0.8128" layer="51"/>
<wire x1="-7.874" y1="3.048" x2="-6.985" y2="3.048" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="2.794" x2="-6.985" y2="3.048" width="0.1524" layer="21"/>
<wire x1="-7.874" y1="-3.048" x2="-6.985" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="-2.794" x2="-6.985" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="6.731" y1="2.794" x2="6.985" y2="3.048" width="0.1524" layer="21"/>
<wire x1="6.731" y1="2.794" x2="-6.731" y2="2.794" width="0.1524" layer="21"/>
<wire x1="6.731" y1="-2.794" x2="6.985" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="6.731" y1="-2.794" x2="-6.731" y2="-2.794" width="0.1524" layer="21"/>
<wire x1="7.874" y1="3.048" x2="6.985" y2="3.048" width="0.1524" layer="21"/>
<wire x1="7.874" y1="-3.048" x2="6.985" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="-8.255" y1="-2.667" x2="-8.255" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="-8.255" y1="1.016" x2="-8.255" y2="-1.016" width="0.1524" layer="51"/>
<wire x1="-8.255" y1="1.016" x2="-8.255" y2="2.667" width="0.1524" layer="21"/>
<wire x1="8.255" y1="-2.667" x2="8.255" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="8.255" y1="1.016" x2="8.255" y2="-1.016" width="0.1524" layer="51"/>
<wire x1="8.255" y1="1.016" x2="8.255" y2="2.667" width="0.1524" layer="21"/>
<wire x1="8.636" y1="0" x2="8.89" y2="0" width="0.8128" layer="51"/>
<wire x1="-8.255" y1="2.667" x2="-7.874" y2="3.048" width="0.1524" layer="21" curve="-90"/>
<wire x1="7.874" y1="3.048" x2="8.255" y2="2.667" width="0.1524" layer="21" curve="-90"/>
<wire x1="-8.255" y1="-2.667" x2="-7.874" y2="-3.048" width="0.1524" layer="21" curve="90"/>
<wire x1="7.874" y1="-3.048" x2="8.255" y2="-2.667" width="0.1524" layer="21" curve="90"/>
<pad name="1" x="-8.89" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="8.89" y="0" drill="1.016" shape="octagon"/>
<text x="-8.128" y="3.4544" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-6.096" y="-0.7112" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-8.5344" y1="-0.4064" x2="-8.2296" y2="0.4064" layer="51"/>
<rectangle x1="8.2296" y1="-0.4064" x2="8.5344" y2="0.4064" layer="51"/>
</package>
<package name="0617/22">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0617, grid 22.5 mm</description>
<wire x1="-10.287" y1="0" x2="-11.43" y2="0" width="0.8128" layer="51"/>
<wire x1="-8.255" y1="-2.667" x2="-8.255" y2="2.667" width="0.1524" layer="21"/>
<wire x1="-7.874" y1="3.048" x2="-6.985" y2="3.048" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="2.794" x2="-6.985" y2="3.048" width="0.1524" layer="21"/>
<wire x1="-7.874" y1="-3.048" x2="-6.985" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="-6.731" y1="-2.794" x2="-6.985" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="6.731" y1="2.794" x2="6.985" y2="3.048" width="0.1524" layer="21"/>
<wire x1="6.731" y1="2.794" x2="-6.731" y2="2.794" width="0.1524" layer="21"/>
<wire x1="6.731" y1="-2.794" x2="6.985" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="6.731" y1="-2.794" x2="-6.731" y2="-2.794" width="0.1524" layer="21"/>
<wire x1="7.874" y1="3.048" x2="6.985" y2="3.048" width="0.1524" layer="21"/>
<wire x1="7.874" y1="-3.048" x2="6.985" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="8.255" y1="-2.667" x2="8.255" y2="2.667" width="0.1524" layer="21"/>
<wire x1="11.43" y1="0" x2="10.287" y2="0" width="0.8128" layer="51"/>
<wire x1="-8.255" y1="2.667" x2="-7.874" y2="3.048" width="0.1524" layer="21" curve="-90"/>
<wire x1="-8.255" y1="-2.667" x2="-7.874" y2="-3.048" width="0.1524" layer="21" curve="90"/>
<wire x1="7.874" y1="3.048" x2="8.255" y2="2.667" width="0.1524" layer="21" curve="-90"/>
<wire x1="7.874" y1="-3.048" x2="8.255" y2="-2.667" width="0.1524" layer="21" curve="90"/>
<pad name="1" x="-11.43" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="11.43" y="0" drill="1.016" shape="octagon"/>
<text x="-8.255" y="3.4544" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-6.477" y="-0.5842" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-10.1854" y1="-0.4064" x2="-8.255" y2="0.4064" layer="21"/>
<rectangle x1="8.255" y1="-0.4064" x2="10.1854" y2="0.4064" layer="21"/>
</package>
<package name="0617V">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0617, grid 5 mm</description>
<wire x1="-2.54" y1="0" x2="-1.27" y2="0" width="0.8128" layer="51"/>
<wire x1="1.27" y1="0" x2="2.54" y2="0" width="0.8128" layer="51"/>
<circle x="-2.54" y="0" radius="3.048" width="0.1524" layer="21"/>
<circle x="-2.54" y="0" radius="1.143" width="0.1524" layer="51"/>
<pad name="1" x="-2.54" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="1.016" shape="octagon"/>
<text x="0.635" y="1.4224" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="0.635" y="-2.6162" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-1.3208" y1="-0.4064" x2="1.3208" y2="0.4064" layer="21"/>
</package>
<package name="0922/22">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0922, grid 22.5 mm</description>
<wire x1="11.43" y1="0" x2="10.795" y2="0" width="0.8128" layer="51"/>
<wire x1="-11.43" y1="0" x2="-10.795" y2="0" width="0.8128" layer="51"/>
<wire x1="-10.16" y1="-4.191" x2="-10.16" y2="4.191" width="0.1524" layer="21"/>
<wire x1="-9.779" y1="4.572" x2="-8.89" y2="4.572" width="0.1524" layer="21"/>
<wire x1="-8.636" y1="4.318" x2="-8.89" y2="4.572" width="0.1524" layer="21"/>
<wire x1="-9.779" y1="-4.572" x2="-8.89" y2="-4.572" width="0.1524" layer="21"/>
<wire x1="-8.636" y1="-4.318" x2="-8.89" y2="-4.572" width="0.1524" layer="21"/>
<wire x1="8.636" y1="4.318" x2="8.89" y2="4.572" width="0.1524" layer="21"/>
<wire x1="8.636" y1="4.318" x2="-8.636" y2="4.318" width="0.1524" layer="21"/>
<wire x1="8.636" y1="-4.318" x2="8.89" y2="-4.572" width="0.1524" layer="21"/>
<wire x1="8.636" y1="-4.318" x2="-8.636" y2="-4.318" width="0.1524" layer="21"/>
<wire x1="9.779" y1="4.572" x2="8.89" y2="4.572" width="0.1524" layer="21"/>
<wire x1="9.779" y1="-4.572" x2="8.89" y2="-4.572" width="0.1524" layer="21"/>
<wire x1="10.16" y1="-4.191" x2="10.16" y2="4.191" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="-4.191" x2="-9.779" y2="-4.572" width="0.1524" layer="21" curve="90"/>
<wire x1="-10.16" y1="4.191" x2="-9.779" y2="4.572" width="0.1524" layer="21" curve="-90"/>
<wire x1="9.779" y1="-4.572" x2="10.16" y2="-4.191" width="0.1524" layer="21" curve="90"/>
<wire x1="9.779" y1="4.572" x2="10.16" y2="4.191" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-11.43" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="11.43" y="0" drill="1.016" shape="octagon"/>
<text x="-10.16" y="5.1054" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-6.477" y="-0.5842" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-10.7188" y1="-0.4064" x2="-10.16" y2="0.4064" layer="51"/>
<rectangle x1="10.16" y1="-0.4064" x2="10.3124" y2="0.4064" layer="21"/>
<rectangle x1="-10.3124" y1="-0.4064" x2="-10.16" y2="0.4064" layer="21"/>
<rectangle x1="10.16" y1="-0.4064" x2="10.7188" y2="0.4064" layer="51"/>
</package>
<package name="P0613V">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0613, grid 5 mm</description>
<wire x1="2.54" y1="0" x2="1.397" y2="0" width="0.8128" layer="51"/>
<wire x1="-2.54" y1="0" x2="-1.397" y2="0" width="0.8128" layer="51"/>
<circle x="-2.54" y="0" radius="2.286" width="0.1524" layer="21"/>
<circle x="-2.54" y="0" radius="1.143" width="0.1524" layer="51"/>
<pad name="1" x="-2.54" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="1.016" shape="octagon"/>
<text x="-0.254" y="1.143" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-0.254" y="-2.413" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-1.2954" y1="-0.4064" x2="1.3208" y2="0.4064" layer="21"/>
</package>
<package name="P0613/15">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0613, grid 15 mm</description>
<wire x1="7.62" y1="0" x2="6.985" y2="0" width="0.8128" layer="51"/>
<wire x1="-7.62" y1="0" x2="-6.985" y2="0" width="0.8128" layer="51"/>
<wire x1="-6.477" y1="2.032" x2="-6.223" y2="2.286" width="0.1524" layer="21" curve="-90"/>
<wire x1="-6.477" y1="-2.032" x2="-6.223" y2="-2.286" width="0.1524" layer="21" curve="90"/>
<wire x1="6.223" y1="-2.286" x2="6.477" y2="-2.032" width="0.1524" layer="21" curve="90"/>
<wire x1="6.223" y1="2.286" x2="6.477" y2="2.032" width="0.1524" layer="21" curve="-90"/>
<wire x1="-6.223" y1="2.286" x2="-5.334" y2="2.286" width="0.1524" layer="21"/>
<wire x1="-5.207" y1="2.159" x2="-5.334" y2="2.286" width="0.1524" layer="21"/>
<wire x1="-6.223" y1="-2.286" x2="-5.334" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="-5.207" y1="-2.159" x2="-5.334" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="5.207" y1="2.159" x2="5.334" y2="2.286" width="0.1524" layer="21"/>
<wire x1="5.207" y1="2.159" x2="-5.207" y2="2.159" width="0.1524" layer="21"/>
<wire x1="5.207" y1="-2.159" x2="5.334" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="5.207" y1="-2.159" x2="-5.207" y2="-2.159" width="0.1524" layer="21"/>
<wire x1="6.223" y1="2.286" x2="5.334" y2="2.286" width="0.1524" layer="21"/>
<wire x1="6.223" y1="-2.286" x2="5.334" y2="-2.286" width="0.1524" layer="21"/>
<wire x1="6.477" y1="-0.635" x2="6.477" y2="-2.032" width="0.1524" layer="21"/>
<wire x1="6.477" y1="-0.635" x2="6.477" y2="0.635" width="0.1524" layer="51"/>
<wire x1="6.477" y1="2.032" x2="6.477" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-6.477" y1="-2.032" x2="-6.477" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-6.477" y1="0.635" x2="-6.477" y2="-0.635" width="0.1524" layer="51"/>
<wire x1="-6.477" y1="0.635" x2="-6.477" y2="2.032" width="0.1524" layer="21"/>
<pad name="1" x="-7.62" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="7.62" y="0" drill="1.016" shape="octagon"/>
<text x="-6.477" y="2.6924" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-4.318" y="-0.7112" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-7.0358" y1="-0.4064" x2="-6.477" y2="0.4064" layer="51"/>
<rectangle x1="6.477" y1="-0.4064" x2="7.0358" y2="0.4064" layer="51"/>
</package>
<package name="P0817/22">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0817, grid 22.5 mm</description>
<wire x1="-10.414" y1="0" x2="-11.43" y2="0" width="0.8128" layer="51"/>
<wire x1="-8.509" y1="-3.429" x2="-8.509" y2="3.429" width="0.1524" layer="21"/>
<wire x1="-8.128" y1="3.81" x2="-7.239" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-6.985" y1="3.556" x2="-7.239" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-8.128" y1="-3.81" x2="-7.239" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-6.985" y1="-3.556" x2="-7.239" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="6.985" y1="3.556" x2="7.239" y2="3.81" width="0.1524" layer="21"/>
<wire x1="6.985" y1="3.556" x2="-6.985" y2="3.556" width="0.1524" layer="21"/>
<wire x1="6.985" y1="-3.556" x2="7.239" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="6.985" y1="-3.556" x2="-6.985" y2="-3.556" width="0.1524" layer="21"/>
<wire x1="8.128" y1="3.81" x2="7.239" y2="3.81" width="0.1524" layer="21"/>
<wire x1="8.128" y1="-3.81" x2="7.239" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="8.509" y1="-3.429" x2="8.509" y2="3.429" width="0.1524" layer="21"/>
<wire x1="11.43" y1="0" x2="10.414" y2="0" width="0.8128" layer="51"/>
<wire x1="-8.509" y1="3.429" x2="-8.128" y2="3.81" width="0.1524" layer="21" curve="-90"/>
<wire x1="-8.509" y1="-3.429" x2="-8.128" y2="-3.81" width="0.1524" layer="21" curve="90"/>
<wire x1="8.128" y1="3.81" x2="8.509" y2="3.429" width="0.1524" layer="21" curve="-90"/>
<wire x1="8.128" y1="-3.81" x2="8.509" y2="-3.429" width="0.1524" layer="21" curve="90"/>
<pad name="1" x="-11.43" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="11.43" y="0" drill="1.016" shape="octagon"/>
<text x="-8.382" y="4.2164" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-6.223" y="-0.5842" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<text x="6.604" y="-2.2606" size="1.27" layer="51" ratio="10" rot="R90">0817</text>
<rectangle x1="8.509" y1="-0.4064" x2="10.3124" y2="0.4064" layer="21"/>
<rectangle x1="-10.3124" y1="-0.4064" x2="-8.509" y2="0.4064" layer="21"/>
</package>
<package name="P0817V">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0817, grid 6.35 mm</description>
<wire x1="-3.81" y1="0" x2="-5.08" y2="0" width="0.8128" layer="51"/>
<wire x1="1.27" y1="0" x2="0" y2="0" width="0.8128" layer="51"/>
<circle x="-5.08" y="0" radius="3.81" width="0.1524" layer="21"/>
<circle x="-5.08" y="0" radius="1.27" width="0.1524" layer="51"/>
<pad name="1" x="-5.08" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="1.016" shape="octagon"/>
<text x="-1.016" y="1.27" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-1.016" y="-2.54" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<text x="-6.858" y="2.032" size="1.016" layer="21" ratio="12">0817</text>
<rectangle x1="-3.81" y1="-0.4064" x2="0" y2="0.4064" layer="21"/>
</package>
<package name="V234/12">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type V234, grid 12.5 mm</description>
<wire x1="-4.953" y1="1.524" x2="-4.699" y2="1.778" width="0.1524" layer="21" curve="-90"/>
<wire x1="4.699" y1="1.778" x2="4.953" y2="1.524" width="0.1524" layer="21" curve="-90"/>
<wire x1="4.699" y1="-1.778" x2="4.953" y2="-1.524" width="0.1524" layer="21" curve="90"/>
<wire x1="-4.953" y1="-1.524" x2="-4.699" y2="-1.778" width="0.1524" layer="21" curve="90"/>
<wire x1="-4.699" y1="1.778" x2="4.699" y2="1.778" width="0.1524" layer="21"/>
<wire x1="-4.953" y1="1.524" x2="-4.953" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="4.699" y1="-1.778" x2="-4.699" y2="-1.778" width="0.1524" layer="21"/>
<wire x1="4.953" y1="1.524" x2="4.953" y2="-1.524" width="0.1524" layer="21"/>
<wire x1="6.35" y1="0" x2="5.461" y2="0" width="0.8128" layer="51"/>
<wire x1="-6.35" y1="0" x2="-5.461" y2="0" width="0.8128" layer="51"/>
<pad name="1" x="-6.35" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="6.35" y="0" drill="1.016" shape="octagon"/>
<text x="-4.953" y="2.159" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.81" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="4.953" y1="-0.4064" x2="5.4102" y2="0.4064" layer="21"/>
<rectangle x1="-5.4102" y1="-0.4064" x2="-4.953" y2="0.4064" layer="21"/>
</package>
<package name="V235/17">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type V235, grid 17.78 mm</description>
<wire x1="-6.731" y1="2.921" x2="6.731" y2="2.921" width="0.1524" layer="21"/>
<wire x1="-7.112" y1="2.54" x2="-7.112" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="6.731" y1="-2.921" x2="-6.731" y2="-2.921" width="0.1524" layer="21"/>
<wire x1="7.112" y1="2.54" x2="7.112" y2="-2.54" width="0.1524" layer="21"/>
<wire x1="8.89" y1="0" x2="7.874" y2="0" width="1.016" layer="51"/>
<wire x1="-7.874" y1="0" x2="-8.89" y2="0" width="1.016" layer="51"/>
<wire x1="-7.112" y1="-2.54" x2="-6.731" y2="-2.921" width="0.1524" layer="21" curve="90"/>
<wire x1="6.731" y1="2.921" x2="7.112" y2="2.54" width="0.1524" layer="21" curve="-90"/>
<wire x1="6.731" y1="-2.921" x2="7.112" y2="-2.54" width="0.1524" layer="21" curve="90"/>
<wire x1="-7.112" y1="2.54" x2="-6.731" y2="2.921" width="0.1524" layer="21" curve="-90"/>
<pad name="1" x="-8.89" y="0" drill="1.1938" shape="octagon"/>
<pad name="2" x="8.89" y="0" drill="1.1938" shape="octagon"/>
<text x="-6.858" y="3.302" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.842" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="7.112" y1="-0.508" x2="7.747" y2="0.508" layer="21"/>
<rectangle x1="-7.747" y1="-0.508" x2="-7.112" y2="0.508" layer="21"/>
</package>
<package name="V526-0">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type V526-0, grid 2.5 mm</description>
<wire x1="-2.54" y1="1.016" x2="-2.286" y2="1.27" width="0.1524" layer="21" curve="-90"/>
<wire x1="2.286" y1="1.27" x2="2.54" y2="1.016" width="0.1524" layer="21" curve="-90"/>
<wire x1="2.286" y1="-1.27" x2="2.54" y2="-1.016" width="0.1524" layer="21" curve="90"/>
<wire x1="-2.54" y1="-1.016" x2="-2.286" y2="-1.27" width="0.1524" layer="21" curve="90"/>
<wire x1="2.286" y1="1.27" x2="-2.286" y2="1.27" width="0.1524" layer="21"/>
<wire x1="2.54" y1="-1.016" x2="2.54" y2="1.016" width="0.1524" layer="21"/>
<wire x1="-2.286" y1="-1.27" x2="2.286" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="1.016" x2="-2.54" y2="-1.016" width="0.1524" layer="21"/>
<pad name="1" x="-1.27" y="0" drill="0.8128" shape="octagon"/>
<pad name="2" x="1.27" y="0" drill="0.8128" shape="octagon"/>
<text x="-2.413" y="1.651" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-2.413" y="-2.794" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
<package name="MINI_MELF-0102R">
<description>&lt;b&gt;CECC Size RC2211&lt;/b&gt; Reflow Soldering&lt;p&gt;
source Beyschlag</description>
<wire x1="-1" y1="-0.5" x2="1" y2="-0.5" width="0.2032" layer="51"/>
<wire x1="1" y1="-0.5" x2="1" y2="0.5" width="0.2032" layer="51"/>
<wire x1="1" y1="0.5" x2="-1" y2="0.5" width="0.2032" layer="51"/>
<wire x1="-1" y1="0.5" x2="-1" y2="-0.5" width="0.2032" layer="51"/>
<smd name="1" x="-0.9" y="0" dx="0.5" dy="1.3" layer="1"/>
<smd name="2" x="0.9" y="0" dx="0.5" dy="1.3" layer="1"/>
<text x="-1.27" y="0.9525" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.2225" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="MINI_MELF-0102W">
<description>&lt;b&gt;CECC Size RC2211&lt;/b&gt; Wave Soldering&lt;p&gt;
source Beyschlag</description>
<wire x1="-1" y1="-0.5" x2="1" y2="-0.5" width="0.2032" layer="51"/>
<wire x1="1" y1="-0.5" x2="1" y2="0.5" width="0.2032" layer="51"/>
<wire x1="1" y1="0.5" x2="-1" y2="0.5" width="0.2032" layer="51"/>
<wire x1="-1" y1="0.5" x2="-1" y2="-0.5" width="0.2032" layer="51"/>
<smd name="1" x="-0.95" y="0" dx="0.6" dy="1.3" layer="1"/>
<smd name="2" x="0.95" y="0" dx="0.6" dy="1.3" layer="1"/>
<text x="-1.27" y="0.9525" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.2225" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="MINI_MELF-0204R">
<description>&lt;b&gt;CECC Size RC3715&lt;/b&gt; Reflow Soldering&lt;p&gt;
source Beyschlag</description>
<wire x1="-1.7" y1="-0.6" x2="1.7" y2="-0.6" width="0.2032" layer="51"/>
<wire x1="1.7" y1="-0.6" x2="1.7" y2="0.6" width="0.2032" layer="51"/>
<wire x1="1.7" y1="0.6" x2="-1.7" y2="0.6" width="0.2032" layer="51"/>
<wire x1="-1.7" y1="0.6" x2="-1.7" y2="-0.6" width="0.2032" layer="51"/>
<wire x1="0.938" y1="0.6" x2="-0.938" y2="0.6" width="0.2032" layer="21"/>
<wire x1="-0.938" y1="-0.6" x2="0.938" y2="-0.6" width="0.2032" layer="21"/>
<smd name="1" x="-1.5" y="0" dx="0.8" dy="1.6" layer="1"/>
<smd name="2" x="1.5" y="0" dx="0.8" dy="1.6" layer="1"/>
<text x="-1.27" y="0.9525" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.2225" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="MINI_MELF-0204W">
<description>&lt;b&gt;CECC Size RC3715&lt;/b&gt; Wave Soldering&lt;p&gt;
source Beyschlag</description>
<wire x1="-1.7" y1="-0.6" x2="1.7" y2="-0.6" width="0.2032" layer="51"/>
<wire x1="1.7" y1="-0.6" x2="1.7" y2="0.6" width="0.2032" layer="51"/>
<wire x1="1.7" y1="0.6" x2="-1.7" y2="0.6" width="0.2032" layer="51"/>
<wire x1="-1.7" y1="0.6" x2="-1.7" y2="-0.6" width="0.2032" layer="51"/>
<wire x1="0.684" y1="0.6" x2="-0.684" y2="0.6" width="0.2032" layer="21"/>
<wire x1="-0.684" y1="-0.6" x2="0.684" y2="-0.6" width="0.2032" layer="21"/>
<smd name="1" x="-1.5" y="0" dx="1.2" dy="1.6" layer="1"/>
<smd name="2" x="1.5" y="0" dx="1.2" dy="1.6" layer="1"/>
<text x="-1.27" y="0.9525" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.2225" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="MINI_MELF-0207R">
<description>&lt;b&gt;CECC Size RC6123&lt;/b&gt; Reflow Soldering&lt;p&gt;
source Beyschlag</description>
<wire x1="-2.8" y1="-1" x2="2.8" y2="-1" width="0.2032" layer="51"/>
<wire x1="2.8" y1="-1" x2="2.8" y2="1" width="0.2032" layer="51"/>
<wire x1="2.8" y1="1" x2="-2.8" y2="1" width="0.2032" layer="51"/>
<wire x1="-2.8" y1="1" x2="-2.8" y2="-1" width="0.2032" layer="51"/>
<wire x1="1.2125" y1="1" x2="-1.2125" y2="1" width="0.2032" layer="21"/>
<wire x1="-1.2125" y1="-1" x2="1.2125" y2="-1" width="0.2032" layer="21"/>
<smd name="1" x="-2.25" y="0" dx="1.6" dy="2.5" layer="1"/>
<smd name="2" x="2.25" y="0" dx="1.6" dy="2.5" layer="1"/>
<text x="-2.2225" y="1.5875" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.2225" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="MINI_MELF-0207W">
<description>&lt;b&gt;CECC Size RC6123&lt;/b&gt; Wave Soldering&lt;p&gt;
source Beyschlag</description>
<wire x1="-2.8" y1="-1" x2="2.8" y2="-1" width="0.2032" layer="51"/>
<wire x1="2.8" y1="-1" x2="2.8" y2="1" width="0.2032" layer="51"/>
<wire x1="2.8" y1="1" x2="-2.8" y2="1" width="0.2032" layer="51"/>
<wire x1="-2.8" y1="1" x2="-2.8" y2="-1" width="0.2032" layer="51"/>
<wire x1="1.149" y1="1" x2="-1.149" y2="1" width="0.2032" layer="21"/>
<wire x1="-1.149" y1="-1" x2="1.149" y2="-1" width="0.2032" layer="21"/>
<smd name="1" x="-2.6" y="0" dx="2.4" dy="2.5" layer="1"/>
<smd name="2" x="2.6" y="0" dx="2.4" dy="2.5" layer="1"/>
<text x="-2.54" y="1.5875" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-2.54" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="0922V">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type 0922, grid 7.5 mm</description>
<wire x1="2.54" y1="0" x2="1.397" y2="0" width="0.8128" layer="51"/>
<wire x1="-5.08" y1="0" x2="-3.81" y2="0" width="0.8128" layer="51"/>
<circle x="-5.08" y="0" radius="4.572" width="0.1524" layer="21"/>
<circle x="-5.08" y="0" radius="1.905" width="0.1524" layer="21"/>
<pad name="1" x="-5.08" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="2.54" y="0" drill="1.016" shape="octagon"/>
<text x="-0.508" y="1.6764" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-0.508" y="-2.9972" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<text x="-6.858" y="2.54" size="1.016" layer="21" ratio="12">0922</text>
<rectangle x1="-3.81" y1="-0.4064" x2="1.3208" y2="0.4064" layer="21"/>
</package>
<package name="RDH/15">
<description>&lt;b&gt;RESISTOR&lt;/b&gt;&lt;p&gt;
type RDH, grid 15 mm</description>
<wire x1="-7.62" y1="0" x2="-6.858" y2="0" width="0.8128" layer="51"/>
<wire x1="-6.096" y1="3.048" x2="-5.207" y2="3.048" width="0.1524" layer="21"/>
<wire x1="-4.953" y1="2.794" x2="-5.207" y2="3.048" width="0.1524" layer="21"/>
<wire x1="-6.096" y1="-3.048" x2="-5.207" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="-4.953" y1="-2.794" x2="-5.207" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="4.953" y1="2.794" x2="5.207" y2="3.048" width="0.1524" layer="21"/>
<wire x1="4.953" y1="2.794" x2="-4.953" y2="2.794" width="0.1524" layer="21"/>
<wire x1="4.953" y1="-2.794" x2="5.207" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="4.953" y1="-2.794" x2="-4.953" y2="-2.794" width="0.1524" layer="21"/>
<wire x1="6.096" y1="3.048" x2="5.207" y2="3.048" width="0.1524" layer="21"/>
<wire x1="6.096" y1="-3.048" x2="5.207" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="-6.477" y1="-2.667" x2="-6.477" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="-6.477" y1="1.016" x2="-6.477" y2="-1.016" width="0.1524" layer="51"/>
<wire x1="-6.477" y1="1.016" x2="-6.477" y2="2.667" width="0.1524" layer="21"/>
<wire x1="6.477" y1="-2.667" x2="6.477" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="6.477" y1="1.016" x2="6.477" y2="-1.016" width="0.1524" layer="51"/>
<wire x1="6.477" y1="1.016" x2="6.477" y2="2.667" width="0.1524" layer="21"/>
<wire x1="6.858" y1="0" x2="7.62" y2="0" width="0.8128" layer="51"/>
<wire x1="-6.477" y1="2.667" x2="-6.096" y2="3.048" width="0.1524" layer="21" curve="-90"/>
<wire x1="6.096" y1="3.048" x2="6.477" y2="2.667" width="0.1524" layer="21" curve="-90"/>
<wire x1="-6.477" y1="-2.667" x2="-6.096" y2="-3.048" width="0.1524" layer="21" curve="90"/>
<wire x1="6.096" y1="-3.048" x2="6.477" y2="-2.667" width="0.1524" layer="21" curve="90"/>
<pad name="1" x="-7.62" y="0" drill="1.016" shape="octagon"/>
<pad name="2" x="7.62" y="0" drill="1.016" shape="octagon"/>
<text x="-6.35" y="3.4544" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-4.318" y="-0.5842" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<text x="4.572" y="-1.7272" size="1.27" layer="51" ratio="10" rot="R90">RDH</text>
<rectangle x1="-6.7564" y1="-0.4064" x2="-6.4516" y2="0.4064" layer="51"/>
<rectangle x1="6.4516" y1="-0.4064" x2="6.7564" y2="0.4064" layer="51"/>
</package>
<package name="MINI_MELF-0102AX">
<description>&lt;b&gt;Mini MELF 0102 Axial&lt;/b&gt;</description>
<circle x="0" y="0" radius="0.6" width="0" layer="51"/>
<circle x="0" y="0" radius="0.6" width="0" layer="52"/>
<smd name="1" x="0" y="0" dx="1.9" dy="1.9" layer="1" roundness="100"/>
<smd name="2" x="0" y="0" dx="1.9" dy="1.9" layer="16" roundness="100"/>
<text x="-1.27" y="0.9525" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.27" y="-2.2225" size="1.27" layer="27">&gt;VALUE</text>
<hole x="0" y="0" drill="1.3"/>
</package>
<package name="R0201">
<description>&lt;b&gt;RESISTOR&lt;/b&gt; chip&lt;p&gt;
Source: http://www.vishay.com/docs/20008/dcrcw.pdf</description>
<smd name="1" x="-0.255" y="0" dx="0.28" dy="0.43" layer="1"/>
<smd name="2" x="0.255" y="0" dx="0.28" dy="0.43" layer="1"/>
<text x="-0.635" y="0.635" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-1.905" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-0.3" y1="-0.15" x2="-0.15" y2="0.15" layer="51"/>
<rectangle x1="0.15" y1="-0.15" x2="0.3" y2="0.15" layer="51"/>
<rectangle x1="-0.15" y1="-0.15" x2="0.15" y2="0.15" layer="21"/>
</package>
<package name="VTA52">
<description>&lt;b&gt;Bulk Metal® Foil Technology&lt;/b&gt;, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements&lt;p&gt;
MIL SIZE RBR52&lt;br&gt;
Source: VISHAY .. vta56.pdf</description>
<wire x1="-15.24" y1="0" x2="-13.97" y2="0" width="0.6096" layer="51"/>
<wire x1="12.6225" y1="0.025" x2="12.6225" y2="4.725" width="0.1524" layer="21"/>
<wire x1="12.6225" y1="4.725" x2="-12.6225" y2="4.725" width="0.1524" layer="21"/>
<wire x1="-12.6225" y1="4.725" x2="-12.6225" y2="0.025" width="0.1524" layer="21"/>
<wire x1="-12.6225" y1="0.025" x2="-12.6225" y2="-4.65" width="0.1524" layer="21"/>
<wire x1="-12.6225" y1="-4.65" x2="12.6225" y2="-4.65" width="0.1524" layer="21"/>
<wire x1="12.6225" y1="-4.65" x2="12.6225" y2="0.025" width="0.1524" layer="21"/>
<wire x1="13.97" y1="0" x2="15.24" y2="0" width="0.6096" layer="51"/>
<pad name="1" x="-15.24" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="15.24" y="0" drill="1.1" shape="octagon"/>
<text x="-3.81" y="5.08" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.175" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-13.97" y1="-0.3048" x2="-12.5675" y2="0.3048" layer="21"/>
<rectangle x1="12.5675" y1="-0.3048" x2="13.97" y2="0.3048" layer="21"/>
</package>
<package name="VTA53">
<description>&lt;b&gt;Bulk Metal® Foil Technology&lt;/b&gt;, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements&lt;p&gt;
MIL SIZE RBR53&lt;br&gt;
Source: VISHAY .. vta56.pdf</description>
<wire x1="-12.065" y1="0" x2="-10.795" y2="0" width="0.6096" layer="51"/>
<wire x1="9.8975" y1="0" x2="9.8975" y2="4.7" width="0.1524" layer="21"/>
<wire x1="9.8975" y1="4.7" x2="-9.8975" y2="4.7" width="0.1524" layer="21"/>
<wire x1="-9.8975" y1="4.7" x2="-9.8975" y2="0" width="0.1524" layer="21"/>
<wire x1="-9.8975" y1="0" x2="-9.8975" y2="-4.675" width="0.1524" layer="21"/>
<wire x1="-9.8975" y1="-4.675" x2="9.8975" y2="-4.675" width="0.1524" layer="21"/>
<wire x1="9.8975" y1="-4.675" x2="9.8975" y2="0" width="0.1524" layer="21"/>
<wire x1="10.795" y1="0" x2="12.065" y2="0" width="0.6096" layer="51"/>
<pad name="1" x="-12.065" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="12.065" y="0" drill="1.1" shape="octagon"/>
<text x="-3.81" y="5.08" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.175" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-10.795" y1="-0.3048" x2="-9.8425" y2="0.3048" layer="21"/>
<rectangle x1="9.8425" y1="-0.3048" x2="10.795" y2="0.3048" layer="21"/>
</package>
<package name="VTA54">
<description>&lt;b&gt;Bulk Metal® Foil Technology&lt;/b&gt;, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements&lt;p&gt;
MIL SIZE RBR54&lt;br&gt;
Source: VISHAY .. vta56.pdf</description>
<wire x1="-12.065" y1="0" x2="-10.795" y2="0" width="0.6096" layer="51"/>
<wire x1="9.8975" y1="0" x2="9.8975" y2="3.3" width="0.1524" layer="21"/>
<wire x1="9.8975" y1="3.3" x2="-9.8975" y2="3.3" width="0.1524" layer="21"/>
<wire x1="-9.8975" y1="3.3" x2="-9.8975" y2="0" width="0.1524" layer="21"/>
<wire x1="-9.8975" y1="0" x2="-9.8975" y2="-3.3" width="0.1524" layer="21"/>
<wire x1="-9.8975" y1="-3.3" x2="9.8975" y2="-3.3" width="0.1524" layer="21"/>
<wire x1="9.8975" y1="-3.3" x2="9.8975" y2="0" width="0.1524" layer="21"/>
<wire x1="10.795" y1="0" x2="12.065" y2="0" width="0.6096" layer="51"/>
<pad name="1" x="-12.065" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="12.065" y="0" drill="1.1" shape="octagon"/>
<text x="-3.81" y="3.81" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.175" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-10.795" y1="-0.3048" x2="-9.8425" y2="0.3048" layer="21"/>
<rectangle x1="9.8425" y1="-0.3048" x2="10.795" y2="0.3048" layer="21"/>
</package>
<package name="VTA55">
<description>&lt;b&gt;Bulk Metal® Foil Technology&lt;/b&gt;, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements&lt;p&gt;
MIL SIZE RBR55&lt;br&gt;
Source: VISHAY .. vta56.pdf</description>
<wire x1="-8.255" y1="0" x2="-6.985" y2="0" width="0.6096" layer="51"/>
<wire x1="6.405" y1="0" x2="6.405" y2="3.3" width="0.1524" layer="21"/>
<wire x1="6.405" y1="3.3" x2="-6.405" y2="3.3" width="0.1524" layer="21"/>
<wire x1="-6.405" y1="3.3" x2="-6.405" y2="0" width="0.1524" layer="21"/>
<wire x1="-6.405" y1="0" x2="-6.405" y2="-3.3" width="0.1524" layer="21"/>
<wire x1="-6.405" y1="-3.3" x2="6.405" y2="-3.3" width="0.1524" layer="21"/>
<wire x1="6.405" y1="-3.3" x2="6.405" y2="0" width="0.1524" layer="21"/>
<wire x1="6.985" y1="0" x2="8.255" y2="0" width="0.6096" layer="51"/>
<pad name="1" x="-8.255" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="8.255" y="0" drill="1.1" shape="octagon"/>
<text x="-3.81" y="3.81" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.175" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-6.985" y1="-0.3048" x2="-6.35" y2="0.3048" layer="21"/>
<rectangle x1="6.35" y1="-0.3048" x2="6.985" y2="0.3048" layer="21"/>
</package>
<package name="VTA56">
<description>&lt;b&gt;Bulk Metal® Foil Technology&lt;/b&gt;, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements&lt;p&gt;
MIL SIZE RBR56&lt;br&gt;
Source: VISHAY .. vta56.pdf</description>
<wire x1="-6.35" y1="0" x2="-5.08" y2="0" width="0.6096" layer="51"/>
<wire x1="4.5" y1="0" x2="4.5" y2="3.3" width="0.1524" layer="21"/>
<wire x1="4.5" y1="3.3" x2="-4.5" y2="3.3" width="0.1524" layer="21"/>
<wire x1="-4.5" y1="3.3" x2="-4.5" y2="0" width="0.1524" layer="21"/>
<wire x1="-4.5" y1="0" x2="-4.5" y2="-3.3" width="0.1524" layer="21"/>
<wire x1="-4.5" y1="-3.3" x2="4.5" y2="-3.3" width="0.1524" layer="21"/>
<wire x1="4.5" y1="-3.3" x2="4.5" y2="0" width="0.1524" layer="21"/>
<wire x1="5.08" y1="0" x2="6.35" y2="0" width="0.6096" layer="51"/>
<pad name="1" x="-6.35" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="6.35" y="0" drill="1.1" shape="octagon"/>
<text x="-3.81" y="3.81" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.175" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-5.08" y1="-0.3048" x2="-4.445" y2="0.3048" layer="21"/>
<rectangle x1="4.445" y1="-0.3048" x2="5.08" y2="0.3048" layer="21"/>
</package>
<package name="VMTA55">
<description>&lt;b&gt;Bulk Metal® Foil Technology&lt;/b&gt;, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements&lt;p&gt;
MIL SIZE RNC55&lt;br&gt;
Source: VISHAY .. vta56.pdf</description>
<wire x1="-5.08" y1="0" x2="-4.26" y2="0" width="0.6096" layer="51"/>
<wire x1="3.3375" y1="-1.45" x2="3.3375" y2="1.45" width="0.1524" layer="21"/>
<wire x1="3.3375" y1="1.45" x2="-3.3625" y2="1.45" width="0.1524" layer="21"/>
<wire x1="-3.3625" y1="1.45" x2="-3.3625" y2="-1.45" width="0.1524" layer="21"/>
<wire x1="-3.3625" y1="-1.45" x2="3.3375" y2="-1.45" width="0.1524" layer="21"/>
<wire x1="4.235" y1="0" x2="5.08" y2="0" width="0.6096" layer="51"/>
<pad name="1" x="-5.08" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="5.08" y="0" drill="1.1" shape="octagon"/>
<text x="-3.175" y="1.905" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-3.175" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-4.26" y1="-0.3048" x2="-3.3075" y2="0.3048" layer="21"/>
<rectangle x1="3.2825" y1="-0.3048" x2="4.235" y2="0.3048" layer="21"/>
</package>
<package name="VMTB60">
<description>&lt;b&gt;Bulk Metal® Foil Technology&lt;/b&gt;, Tubular Axial Lead Resistors, Meets or Exceeds MIL-R-39005 Requirements&lt;p&gt;
MIL SIZE RNC60&lt;br&gt;
Source: VISHAY .. vta56.pdf</description>
<wire x1="-6.35" y1="0" x2="-5.585" y2="0" width="0.6096" layer="51"/>
<wire x1="4.6875" y1="-1.95" x2="4.6875" y2="1.95" width="0.1524" layer="21"/>
<wire x1="4.6875" y1="1.95" x2="-4.6875" y2="1.95" width="0.1524" layer="21"/>
<wire x1="-4.6875" y1="1.95" x2="-4.6875" y2="-1.95" width="0.1524" layer="21"/>
<wire x1="-4.6875" y1="-1.95" x2="4.6875" y2="-1.95" width="0.1524" layer="21"/>
<wire x1="5.585" y1="0" x2="6.35" y2="0" width="0.6096" layer="51"/>
<pad name="1" x="-6.35" y="0" drill="1.1" shape="octagon"/>
<pad name="2" x="6.35" y="0" drill="1.1" shape="octagon"/>
<text x="-4.445" y="2.54" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-4.445" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-5.585" y1="-0.3048" x2="-4.6325" y2="0.3048" layer="21"/>
<rectangle x1="4.6325" y1="-0.3048" x2="5.585" y2="0.3048" layer="21"/>
</package>
<package name="R4527">
<description>&lt;b&gt;Package 4527&lt;/b&gt;&lt;p&gt;
Source: http://www.vishay.com/docs/31059/wsrhigh.pdf</description>
<wire x1="-5.675" y1="-3.375" x2="5.65" y2="-3.375" width="0.2032" layer="21"/>
<wire x1="5.65" y1="-3.375" x2="5.65" y2="3.375" width="0.2032" layer="51"/>
<wire x1="5.65" y1="3.375" x2="-5.675" y2="3.375" width="0.2032" layer="21"/>
<wire x1="-5.675" y1="3.375" x2="-5.675" y2="-3.375" width="0.2032" layer="51"/>
<smd name="1" x="-4.575" y="0" dx="3.94" dy="5.84" layer="1"/>
<smd name="2" x="4.575" y="0" dx="3.94" dy="5.84" layer="1"/>
<text x="-5.715" y="3.81" size="1.27" layer="25">&gt;NAME</text>
<text x="-5.715" y="-5.08" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="WSC0001">
<description>&lt;b&gt;Wirewound Resistors, Precision Power&lt;/b&gt;&lt;p&gt;
Source: VISHAY wscwsn.pdf</description>
<wire x1="-3.075" y1="1.8" x2="-3.075" y2="-1.8" width="0.2032" layer="51"/>
<wire x1="-3.075" y1="-1.8" x2="3.075" y2="-1.8" width="0.2032" layer="21"/>
<wire x1="3.075" y1="-1.8" x2="3.075" y2="1.8" width="0.2032" layer="51"/>
<wire x1="3.075" y1="1.8" x2="-3.075" y2="1.8" width="0.2032" layer="21"/>
<wire x1="-3.075" y1="1.8" x2="-3.075" y2="1.606" width="0.2032" layer="21"/>
<wire x1="-3.075" y1="-1.606" x2="-3.075" y2="-1.8" width="0.2032" layer="21"/>
<wire x1="3.075" y1="1.606" x2="3.075" y2="1.8" width="0.2032" layer="21"/>
<wire x1="3.075" y1="-1.8" x2="3.075" y2="-1.606" width="0.2032" layer="21"/>
<smd name="1" x="-2.675" y="0" dx="2.29" dy="2.92" layer="1"/>
<smd name="2" x="2.675" y="0" dx="2.29" dy="2.92" layer="1"/>
<text x="-2.544" y="2.229" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.544" y="-3.501" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="WSC0002">
<description>&lt;b&gt;Wirewound Resistors, Precision Power&lt;/b&gt;&lt;p&gt;
Source: VISHAY wscwsn.pdf</description>
<wire x1="-5.55" y1="3.375" x2="-5.55" y2="-3.375" width="0.2032" layer="51"/>
<wire x1="-5.55" y1="-3.375" x2="5.55" y2="-3.375" width="0.2032" layer="21"/>
<wire x1="5.55" y1="-3.375" x2="5.55" y2="3.375" width="0.2032" layer="51"/>
<wire x1="5.55" y1="3.375" x2="-5.55" y2="3.375" width="0.2032" layer="21"/>
<smd name="1" x="-4.575" y="0.025" dx="3.94" dy="5.84" layer="1"/>
<smd name="2" x="4.575" y="0" dx="3.94" dy="5.84" layer="1"/>
<text x="-5.65" y="3.9" size="1.27" layer="25">&gt;NAME</text>
<text x="-5.65" y="-5.15" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="WSC01/2">
<description>&lt;b&gt;Wirewound Resistors, Precision Power&lt;/b&gt;&lt;p&gt;
Source: VISHAY wscwsn.pdf</description>
<wire x1="-2.45" y1="1.475" x2="-2.45" y2="-1.475" width="0.2032" layer="51"/>
<wire x1="-2.45" y1="-1.475" x2="2.45" y2="-1.475" width="0.2032" layer="21"/>
<wire x1="2.45" y1="-1.475" x2="2.45" y2="1.475" width="0.2032" layer="51"/>
<wire x1="2.45" y1="1.475" x2="-2.45" y2="1.475" width="0.2032" layer="21"/>
<wire x1="-2.45" y1="1.475" x2="-2.45" y2="1.106" width="0.2032" layer="21"/>
<wire x1="-2.45" y1="-1.106" x2="-2.45" y2="-1.475" width="0.2032" layer="21"/>
<wire x1="2.45" y1="1.106" x2="2.45" y2="1.475" width="0.2032" layer="21"/>
<wire x1="2.45" y1="-1.475" x2="2.45" y2="-1.106" width="0.2032" layer="21"/>
<smd name="1" x="-2.1" y="0" dx="2.16" dy="1.78" layer="1"/>
<smd name="2" x="2.1" y="0" dx="2.16" dy="1.78" layer="1"/>
<text x="-2.544" y="1.904" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.544" y="-3.176" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="WSC2515">
<description>&lt;b&gt;Wirewound Resistors, Precision Power&lt;/b&gt;&lt;p&gt;
Source: VISHAY wscwsn.pdf</description>
<wire x1="-3.075" y1="1.8" x2="-3.075" y2="-1.8" width="0.2032" layer="51"/>
<wire x1="-3.075" y1="-1.8" x2="3.05" y2="-1.8" width="0.2032" layer="21"/>
<wire x1="3.05" y1="-1.8" x2="3.05" y2="1.8" width="0.2032" layer="51"/>
<wire x1="3.05" y1="1.8" x2="-3.075" y2="1.8" width="0.2032" layer="21"/>
<wire x1="-3.075" y1="1.8" x2="-3.075" y2="1.606" width="0.2032" layer="21"/>
<wire x1="-3.075" y1="-1.606" x2="-3.075" y2="-1.8" width="0.2032" layer="21"/>
<wire x1="3.05" y1="1.606" x2="3.05" y2="1.8" width="0.2032" layer="21"/>
<wire x1="3.05" y1="-1.8" x2="3.05" y2="-1.606" width="0.2032" layer="21"/>
<smd name="1" x="-2.675" y="0" dx="2.29" dy="2.92" layer="1"/>
<smd name="2" x="2.675" y="0" dx="2.29" dy="2.92" layer="1"/>
<text x="-3.2" y="2.15" size="1.27" layer="25">&gt;NAME</text>
<text x="-3.2" y="-3.4" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="WSC4527">
<description>&lt;b&gt;Wirewound Resistors, Precision Power&lt;/b&gt;&lt;p&gt;
Source: VISHAY wscwsn.pdf</description>
<wire x1="-5.675" y1="3.4" x2="-5.675" y2="-3.375" width="0.2032" layer="51"/>
<wire x1="-5.675" y1="-3.375" x2="5.675" y2="-3.375" width="0.2032" layer="21"/>
<wire x1="5.675" y1="-3.375" x2="5.675" y2="3.4" width="0.2032" layer="51"/>
<wire x1="5.675" y1="3.4" x2="-5.675" y2="3.4" width="0.2032" layer="21"/>
<smd name="1" x="-4.575" y="0.025" dx="3.94" dy="5.84" layer="1"/>
<smd name="2" x="4.575" y="0" dx="3.94" dy="5.84" layer="1"/>
<text x="-5.775" y="3.925" size="1.27" layer="25">&gt;NAME</text>
<text x="-5.775" y="-5.15" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="WSC6927">
<description>&lt;b&gt;Wirewound Resistors, Precision Power&lt;/b&gt;&lt;p&gt;
Source: VISHAY wscwsn.pdf</description>
<wire x1="-8.65" y1="3.375" x2="-8.65" y2="-3.375" width="0.2032" layer="51"/>
<wire x1="-8.65" y1="-3.375" x2="8.65" y2="-3.375" width="0.2032" layer="21"/>
<wire x1="8.65" y1="-3.375" x2="8.65" y2="3.375" width="0.2032" layer="51"/>
<wire x1="8.65" y1="3.375" x2="-8.65" y2="3.375" width="0.2032" layer="21"/>
<smd name="1" x="-7.95" y="0.025" dx="3.94" dy="5.97" layer="1"/>
<smd name="2" x="7.95" y="0" dx="3.94" dy="5.97" layer="1"/>
<text x="-8.75" y="3.9" size="1.27" layer="25">&gt;NAME</text>
<text x="-8.75" y="-5.15" size="1.27" layer="27">&gt;VALUE</text>
</package>
<package name="R1218">
<description>&lt;b&gt;CRCW1218 Thick Film, Rectangular Chip Resistors&lt;/b&gt;&lt;p&gt;
Source: http://www.vishay.com .. dcrcw.pdf</description>
<wire x1="-0.913" y1="-2.219" x2="0.939" y2="-2.219" width="0.1524" layer="51"/>
<wire x1="0.913" y1="2.219" x2="-0.939" y2="2.219" width="0.1524" layer="51"/>
<smd name="1" x="-1.475" y="0" dx="1.05" dy="4.9" layer="1"/>
<smd name="2" x="1.475" y="0" dx="1.05" dy="4.9" layer="1"/>
<text x="-2.54" y="2.54" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.54" y="-3.81" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.651" y1="-2.3" x2="-0.9009" y2="2.3" layer="51"/>
<rectangle x1="0.9144" y1="-2.3" x2="1.6645" y2="2.3" layer="51"/>
</package>
<package name="1812X7R">
<description>&lt;b&gt;Chip Monolithic Ceramic Capacitors&lt;/b&gt; Medium Voltage High Capacitance for General Use&lt;p&gt;
Source: http://www.murata.com .. GRM43DR72E224KW01.pdf</description>
<wire x1="-1.1" y1="1.5" x2="1.1" y2="1.5" width="0.2032" layer="51"/>
<wire x1="1.1" y1="-1.5" x2="-1.1" y2="-1.5" width="0.2032" layer="51"/>
<wire x1="-0.6" y1="1.5" x2="0.6" y2="1.5" width="0.2032" layer="21"/>
<wire x1="0.6" y1="-1.5" x2="-0.6" y2="-1.5" width="0.2032" layer="21"/>
<smd name="1" x="-1.425" y="0" dx="0.8" dy="3.5" layer="1"/>
<smd name="2" x="1.425" y="0" dx="0.8" dy="3.5" layer="1" rot="R180"/>
<text x="-1.9456" y="1.9958" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.9456" y="-3.7738" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-1.4" y1="-1.6" x2="-1.1" y2="1.6" layer="51"/>
<rectangle x1="1.1" y1="-1.6" x2="1.4" y2="1.6" layer="51" rot="R180"/>
</package>
</packages>
<symbols>
<symbol name="R-EU">
<wire x1="-2.54" y1="-0.889" x2="2.54" y2="-0.889" width="0.254" layer="94"/>
<wire x1="2.54" y1="0.889" x2="-2.54" y2="0.889" width="0.254" layer="94"/>
<wire x1="2.54" y1="-0.889" x2="2.54" y2="0.889" width="0.254" layer="94"/>
<wire x1="-2.54" y1="-0.889" x2="-2.54" y2="0.889" width="0.254" layer="94"/>
<text x="-3.81" y="1.4986" size="1.778" layer="95">&gt;NAME</text>
<text x="-3.81" y="-3.302" size="1.778" layer="96">&gt;VALUE</text>
<pin name="2" x="5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1" rot="R180"/>
<pin name="1" x="-5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="R-EU_" prefix="R" uservalue="yes">
<description>&lt;B&gt;RESISTOR&lt;/B&gt;, European symbol</description>
<gates>
<gate name="G$1" symbol="R-EU" x="0" y="0"/>
</gates>
<devices>
<device name="R0402" package="R0402">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R0603" package="R0603">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R0805" package="R0805">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R0805W" package="R0805W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R1005" package="R1005">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R1206" package="R1206">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R1206W" package="R1206W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R1210" package="R1210">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R1210W" package="R1210W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R2010" package="R2010">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R2010W" package="R2010W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R2012" package="R2012">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R2012W" package="R2012W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R2512" package="R2512">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R2512W" package="R2512W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R3216" package="R3216">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R3216W" package="R3216W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R3225" package="R3225">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R3225W" package="R3225W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R5025" package="R5025">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R5025W" package="R5025W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R6332" package="R6332">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R6332W" package="R6332W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="M0805" package="M0805">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="M1206" package="M1206">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="M1406" package="M1406">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="M2012" package="M2012">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="M2309" package="M2309">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="M3216" package="M3216">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="M3516" package="M3516">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="M5923" package="M5923">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0204/5" package="0204/5">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0204/7" package="0204/7">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0204/2V" package="0204V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0207/10" package="0207/10">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0207/12" package="0207/12">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0207/15" package="0207/15">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0207/2V" package="0207/2V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0207/5V" package="0207/5V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0207/7" package="0207/7">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0309/10" package="0309/10">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0309/12" package="0309/12">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0309/V" package="0309V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0411/12" package="0411/12">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0411/15" package="0411/15">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0411/3V" package="0411V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0414/15" package="0414/15">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0414/5V" package="0414V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0617/17" package="0617/17">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0617/22" package="0617/22">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0617/5V" package="0617V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0922/22" package="0922/22">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0613/5V" package="P0613V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0613/15" package="P0613/15">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0817/22" package="P0817/22">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0817/7V" package="P0817V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="V234/12" package="V234/12">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="V235/17" package="V235/17">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="V526-0" package="V526-0">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="MELF0102R" package="MINI_MELF-0102R">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="MELF0102W" package="MINI_MELF-0102W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="MELF0204R" package="MINI_MELF-0204R">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="MELF0204W" package="MINI_MELF-0204W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="MELF0207R" package="MINI_MELF-0207R">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="MELF0207W" package="MINI_MELF-0207W">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0922V" package="0922V">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="RDH/15" package="RDH/15">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="MELF0102AX" package="MINI_MELF-0102AX">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R0201" package="R0201">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="VTA52" package="VTA52">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="VTA53" package="VTA53">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="VTA54" package="VTA54">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="VTA55" package="VTA55">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="VTA56" package="VTA56">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="VMTA55" package="VMTA55">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="VMTB60" package="VMTB60">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R4527" package="R4527">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="WSC0001" package="WSC0001">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="WSC0002" package="WSC0002">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="WSC01/2" package="WSC01/2">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="WSC2515" package="WSC2515">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="WSC4527" package="WSC4527">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="WSC6927" package="WSC6927">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="R1218" package="R1218">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="1812X7R" package="1812X7R">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="con-lstb">
<description>&lt;b&gt;Pin Headers&lt;/b&gt;&lt;p&gt;
Naming:&lt;p&gt;
MA = male&lt;p&gt;
# contacts - # rows&lt;p&gt;
W = angled&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="MA06-1">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<wire x1="-6.985" y1="1.27" x2="-5.715" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-5.715" y1="1.27" x2="-5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="-0.635" x2="-5.715" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="0.635" x2="-4.445" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-4.445" y1="1.27" x2="-3.175" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="1.27" x2="-2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="-0.635" x2="-3.175" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="-1.27" x2="-4.445" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-4.445" y1="-1.27" x2="-5.08" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="0.635" x2="-7.62" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-6.985" y1="1.27" x2="-7.62" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="-0.635" x2="-6.985" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-5.715" y1="-1.27" x2="-6.985" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="0.635" x2="-1.905" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="1.27" x2="-0.635" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="1.27" x2="0" y2="0.635" width="0.1524" layer="21"/>
<wire x1="0" y1="-0.635" x2="-0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="-1.27" x2="-1.905" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="-1.27" x2="-2.54" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="0.635" y1="1.27" x2="1.905" y2="1.27" width="0.1524" layer="21"/>
<wire x1="1.905" y1="1.27" x2="2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="2.54" y1="-0.635" x2="1.905" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="2.54" y1="0.635" x2="3.175" y2="1.27" width="0.1524" layer="21"/>
<wire x1="3.175" y1="1.27" x2="4.445" y2="1.27" width="0.1524" layer="21"/>
<wire x1="4.445" y1="1.27" x2="5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="5.08" y1="-0.635" x2="4.445" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="4.445" y1="-1.27" x2="3.175" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="3.175" y1="-1.27" x2="2.54" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="0.635" y1="1.27" x2="0" y2="0.635" width="0.1524" layer="21"/>
<wire x1="0" y1="-0.635" x2="0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="1.905" y1="-1.27" x2="0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="5.08" y1="0.635" x2="5.715" y2="1.27" width="0.1524" layer="21"/>
<wire x1="5.715" y1="1.27" x2="6.985" y2="1.27" width="0.1524" layer="21"/>
<wire x1="6.985" y1="1.27" x2="7.62" y2="0.635" width="0.1524" layer="21"/>
<wire x1="7.62" y1="-0.635" x2="6.985" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="6.985" y1="-1.27" x2="5.715" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="5.715" y1="-1.27" x2="5.08" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="7.62" y1="0.635" x2="7.62" y2="-0.635" width="0.1524" layer="21"/>
<pad name="1" x="-6.35" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="2" x="-3.81" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="3" x="-1.27" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="4" x="1.27" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="5" x="3.81" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="6" x="6.35" y="0" drill="1.016" shape="long" rot="R90"/>
<text x="-7.62" y="1.651" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-6.985" y="-2.921" size="1.27" layer="21" ratio="10">1</text>
<text x="5.715" y="1.651" size="1.27" layer="21" ratio="10">6</text>
<text x="-2.54" y="-2.921" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<rectangle x1="-4.064" y1="-0.254" x2="-3.556" y2="0.254" layer="51"/>
<rectangle x1="-6.604" y1="-0.254" x2="-6.096" y2="0.254" layer="51"/>
<rectangle x1="-1.524" y1="-0.254" x2="-1.016" y2="0.254" layer="51"/>
<rectangle x1="3.556" y1="-0.254" x2="4.064" y2="0.254" layer="51"/>
<rectangle x1="1.016" y1="-0.254" x2="1.524" y2="0.254" layer="51"/>
<rectangle x1="6.096" y1="-0.254" x2="6.604" y2="0.254" layer="51"/>
</package>
</packages>
<symbols>
<symbol name="MA06-1">
<wire x1="3.81" y1="-10.16" x2="-1.27" y2="-10.16" width="0.4064" layer="94"/>
<wire x1="1.27" y1="-2.54" x2="2.54" y2="-2.54" width="0.6096" layer="94"/>
<wire x1="1.27" y1="-5.08" x2="2.54" y2="-5.08" width="0.6096" layer="94"/>
<wire x1="1.27" y1="-7.62" x2="2.54" y2="-7.62" width="0.6096" layer="94"/>
<wire x1="1.27" y1="2.54" x2="2.54" y2="2.54" width="0.6096" layer="94"/>
<wire x1="1.27" y1="0" x2="2.54" y2="0" width="0.6096" layer="94"/>
<wire x1="1.27" y1="5.08" x2="2.54" y2="5.08" width="0.6096" layer="94"/>
<wire x1="-1.27" y1="7.62" x2="-1.27" y2="-10.16" width="0.4064" layer="94"/>
<wire x1="3.81" y1="-10.16" x2="3.81" y2="7.62" width="0.4064" layer="94"/>
<wire x1="-1.27" y1="7.62" x2="3.81" y2="7.62" width="0.4064" layer="94"/>
<text x="-1.27" y="-12.7" size="1.778" layer="96">&gt;VALUE</text>
<text x="-1.27" y="8.382" size="1.778" layer="95">&gt;NAME</text>
<pin name="1" x="7.62" y="-7.62" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="2" x="7.62" y="-5.08" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="3" x="7.62" y="-2.54" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="4" x="7.62" y="0" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="5" x="7.62" y="2.54" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="6" x="7.62" y="5.08" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="MA06-1" prefix="SV" uservalue="yes">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<gates>
<gate name="1" symbol="MA06-1" x="0" y="0"/>
</gates>
<devices>
<device name="" package="MA06-1">
<connects>
<connect gate="1" pin="1" pad="1"/>
<connect gate="1" pin="2" pad="2"/>
<connect gate="1" pin="3" pad="3"/>
<connect gate="1" pin="4" pad="4"/>
<connect gate="1" pin="5" pad="5"/>
<connect gate="1" pin="6" pad="6"/>
</connects>
<technologies>
<technology name="">
<attribute name="MF" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OC_FARNELL" value="unknown" constant="no"/>
<attribute name="OC_NEWARK" value="unknown" constant="no"/>
</technology>
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
<class number="0" name="default" width="0.2032" drill="0.254">
<clearance class="0" value="0.254"/>
</class>
</classes>
<parts>
<part name="U1" library="xilinx_spartan3_virtex4_and_5" deviceset="XC3S400TQ144" device=""/>
<part name="SUPPLY1" library="supply2" deviceset="GND" device=""/>
<part name="SUPPLY2" library="supply2" deviceset="VCC" device=""/>
<part name="SUPPLY3" library="supply2" deviceset="VCC" device=""/>
<part name="SUPPLY4" library="supply2" deviceset="VCC" device=""/>
<part name="SUPPLY5" library="supply2" deviceset="VCC" device=""/>
<part name="U$5" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="U$20" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="U$1" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="U$23" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="U$6" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="U$7" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="U$10" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="U$14" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="U$15" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="U$18" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="U$19" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="U$25" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="U$26" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="U$27" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="U$28" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="U$29" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="U$2" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="U$3" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="SUPPLY6" library="supply2" deviceset="VCC" device=""/>
<part name="SUPPLY7" library="supply2" deviceset="VCC" device=""/>
<part name="IC1" library="smd-special" deviceset="XCF02S" device=""/>
<part name="SUPPLY8" library="supply2" deviceset="GND" device=""/>
<part name="R1" library="rcl" deviceset="R-EU_" device="R0805" value="100"/>
<part name="R2" library="rcl" deviceset="R-EU_" device="R0805" value="100"/>
<part name="R3" library="rcl" deviceset="R-EU_" device="R0805" value="100"/>
<part name="SV1" library="con-lstb" deviceset="MA06-1" device="" value="jtag"/>
<part name="U$4" library="cpcfpga" deviceset="AS6C4008" device=""/>
<part name="U$8" library="cpcfpga" deviceset="NX1117" device="" value="2.5V"/>
<part name="U$9" library="cpcfpga" deviceset="NX1117" device="" value="1.2V"/>
<part name="SUPPLY9" library="supply2" deviceset="VCC" device=""/>
<part name="SUPPLY10" library="supply2" deviceset="GND" device=""/>
<part name="U$11" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="U$12" library="cpcfpga" deviceset="VIA_DIY" device=""/>
<part name="U$13" library="cpcfpga" deviceset="VIA_DIY" device=""/>
</parts>
<sheets>
<sheet>
<plain>
<text x="-152.4" y="99.06" size="1.778" layer="91">ftp://ftp.cadsoft.de/eagle/userfiles/libraries/xilinx_spartan3_virtex4_and_5.lbr</text>
</plain>
<instances>
<instance part="U1" gate="B0" x="-139.7" y="162.56" rot="R90"/>
<instance part="U1" gate="B1" x="-86.36" y="162.56" rot="R90"/>
<instance part="U1" gate="B0AND1" x="-111.76" y="162.56" rot="R90"/>
<instance part="U1" gate="B2" x="-53.34" y="124.46"/>
<instance part="U1" gate="B3" x="-53.34" y="58.42"/>
<instance part="U1" gate="B4" x="-86.36" y="20.32" rot="R270"/>
<instance part="U1" gate="B5" x="-139.7" y="20.32" rot="R270"/>
<instance part="U1" gate="B6" x="-175.26" y="55.88" rot="R180"/>
<instance part="U1" gate="B7" x="-175.26" y="121.92" rot="R180"/>
<instance part="U1" gate="B2AND3" x="-53.34" y="91.44"/>
<instance part="U1" gate="B4AND5" x="-114.3" y="20.32" rot="R270"/>
<instance part="U1" gate="B6AND7" x="-175.26" y="88.9" rot="R180"/>
<instance part="U1" gate="BGND" x="-251.46" y="-33.02"/>
<instance part="U1" gate="BVCCAUX" x="-93.98" y="-22.86"/>
<instance part="U1" gate="BVCCINT" x="-182.88" y="-66.04"/>
<instance part="SUPPLY1" gate="GND" x="-246.38" y="-68.58"/>
<instance part="SUPPLY2" gate="G$1" x="-190.5" y="93.98"/>
<instance part="SUPPLY3" gate="G$1" x="-114.3" y="190.5"/>
<instance part="SUPPLY4" gate="G$1" x="-22.86" y="104.14"/>
<instance part="SUPPLY5" gate="G$1" x="-124.46" y="0"/>
<instance part="U$5" gate="G$1" x="-238.76" y="-25.4"/>
<instance part="U$20" gate="G$1" x="-238.76" y="-45.72"/>
<instance part="U$1" gate="G$1" x="-167.64" y="-63.5"/>
<instance part="U$23" gate="G$1" x="-167.64" y="-68.58"/>
<instance part="U$6" gate="G$1" x="-109.22" y="175.26" rot="R90"/>
<instance part="U$7" gate="G$1" x="-114.3" y="175.26" rot="R90"/>
<instance part="U$10" gate="G$1" x="-111.76" y="175.26" rot="R90"/>
<instance part="U$14" gate="G$1" x="-185.42" y="91.44" rot="R180"/>
<instance part="U$15" gate="G$1" x="-185.42" y="88.9" rot="R180"/>
<instance part="U$18" gate="G$1" x="-185.42" y="86.36" rot="R180"/>
<instance part="U$19" gate="G$1" x="-116.84" y="7.62" rot="R270"/>
<instance part="U$25" gate="G$1" x="-114.3" y="7.62" rot="R270"/>
<instance part="U$26" gate="G$1" x="-111.76" y="7.62" rot="R270"/>
<instance part="U$27" gate="G$1" x="-43.18" y="88.9"/>
<instance part="U$28" gate="G$1" x="-43.18" y="91.44"/>
<instance part="U$29" gate="G$1" x="-43.18" y="93.98"/>
<instance part="U$2" gate="G$1" x="-238.76" y="-30.48"/>
<instance part="U$3" gate="G$1" x="-236.22" y="-53.34"/>
<instance part="SUPPLY6" gate="G$1" x="-109.22" y="187.96"/>
<instance part="SUPPLY7" gate="G$1" x="-106.68" y="0"/>
<instance part="IC1" gate="G$1" x="-22.86" y="-38.1"/>
<instance part="SUPPLY8" gate="GND" x="-43.18" y="-40.64"/>
<instance part="R1" gate="G$1" x="-81.28" y="-22.86"/>
<instance part="R2" gate="G$1" x="-71.12" y="-25.4"/>
<instance part="R3" gate="G$1" x="-81.28" y="-30.48"/>
<instance part="SV1" gate="1" x="50.8" y="27.94" rot="R180"/>
<instance part="U$4" gate="G$1" x="-271.78" y="53.34" rot="R90"/>
<instance part="U$8" gate="G$1" x="-121.92" y="-68.58"/>
<instance part="U$9" gate="G$1" x="-121.92" y="-93.98"/>
<instance part="SUPPLY9" gate="G$1" x="-139.7" y="-45.72"/>
<instance part="SUPPLY10" gate="GND" x="-134.62" y="-109.22"/>
<instance part="U$11" gate="G$1" x="-76.2" y="-45.72" rot="R270"/>
<instance part="U$12" gate="G$1" x="22.86" y="-15.24" rot="R90"/>
<instance part="U$13" gate="G$1" x="22.86" y="0" rot="R270"/>
</instances>
<busses>
</busses>
<nets>
<net name="VCCINT_B" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="B"/>
<label x="-162.56" y="-66.04" size="1.778" layer="95"/>
<pinref part="U$23" gate="G$1" pin="B"/>
<wire x1="-162.56" y1="-68.58" x2="-162.56" y2="-63.5" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="T"/>
<pinref part="U1" gate="BVCCINT" pin="VCCINT0"/>
<pinref part="U1" gate="BVCCINT" pin="VCCINT1"/>
<wire x1="-177.8" y1="-66.04" x2="-177.8" y2="-63.5" width="0.1524" layer="91"/>
<junction x="-177.8" y="-63.5"/>
<wire x1="-177.8" y1="-63.5" x2="-172.72" y2="-63.5" width="0.1524" layer="91"/>
<label x="-172.72" y="-60.96" size="1.778" layer="95"/>
<wire x1="-172.72" y1="-63.5" x2="-172.72" y2="-60.96" width="0.1524" layer="91"/>
<junction x="-172.72" y="-63.5"/>
<wire x1="-172.72" y1="-60.96" x2="-162.56" y2="-60.96" width="0.1524" layer="91"/>
<wire x1="-162.56" y1="-60.96" x2="-162.56" y2="-63.5" width="0.1524" layer="91"/>
<junction x="-162.56" y="-63.5"/>
<pinref part="U$9" gate="G$1" pin="VOUT1"/>
<wire x1="-99.06" y1="-91.44" x2="-99.06" y2="-83.82" width="0.1524" layer="91"/>
<wire x1="-99.06" y1="-83.82" x2="-162.56" y2="-83.82" width="0.1524" layer="91"/>
<wire x1="-162.56" y1="-68.58" x2="-162.56" y2="-71.12" width="0.1524" layer="91"/>
<junction x="-162.56" y="-68.58"/>
<pinref part="U1" gate="BVCCINT" pin="VCCINT2"/>
<pinref part="U1" gate="BVCCINT" pin="VCCINT3"/>
<wire x1="-162.56" y1="-71.12" x2="-162.56" y2="-83.82" width="0.1524" layer="91"/>
<wire x1="-177.8" y1="-71.12" x2="-177.8" y2="-68.58" width="0.1524" layer="91"/>
<junction x="-177.8" y="-68.58"/>
<pinref part="U$23" gate="G$1" pin="T"/>
<wire x1="-172.72" y1="-68.58" x2="-177.8" y2="-68.58" width="0.1524" layer="91"/>
<label x="-172.72" y="-73.66" size="1.778" layer="95"/>
<wire x1="-172.72" y1="-68.58" x2="-172.72" y2="-71.12" width="0.1524" layer="91"/>
<junction x="-172.72" y="-68.58"/>
<wire x1="-172.72" y1="-71.12" x2="-162.56" y2="-71.12" width="0.1524" layer="91"/>
<junction x="-162.56" y="-71.12"/>
</segment>
</net>
<net name="VCCAUX" class="0">
<segment>
<pinref part="U1" gate="BVCCAUX" pin="VCCAUX2"/>
<pinref part="U1" gate="BVCCAUX" pin="VCCAUX3"/>
<wire x1="-88.9" y1="-40.64" x2="-88.9" y2="-38.1" width="0.1524" layer="91"/>
<junction x="-88.9" y="-38.1"/>
<pinref part="U1" gate="BVCCAUX" pin="VCCAUX1"/>
<wire x1="-88.9" y1="-38.1" x2="-88.9" y2="-35.56" width="0.1524" layer="91"/>
<junction x="-88.9" y="-35.56"/>
<pinref part="U1" gate="BVCCAUX" pin="VCCAUX0"/>
<wire x1="-88.9" y1="-35.56" x2="-88.9" y2="-33.02" width="0.1524" layer="91"/>
<wire x1="-88.9" y1="-40.64" x2="-76.2" y2="-40.64" width="0.1524" layer="91"/>
<junction x="-88.9" y="-40.64"/>
<label x="-81.28" y="-40.64" size="1.778" layer="95"/>
<wire x1="-76.2" y1="-40.64" x2="-71.12" y2="-40.64" width="0.1524" layer="91"/>
<pinref part="U$11" gate="G$1" pin="T"/>
<junction x="-76.2" y="-40.64"/>
</segment>
</net>
<net name="GND" class="0">
<segment>
<pinref part="U1" gate="BGND" pin="GND15"/>
<pinref part="SUPPLY1" gate="GND" pin="GND"/>
<wire x1="-246.38" y1="-66.04" x2="-246.38" y2="-60.96" width="0.1524" layer="91"/>
<wire x1="-246.38" y1="-60.96" x2="-246.38" y2="-53.34" width="0.1524" layer="91"/>
<wire x1="-266.7" y1="-10.16" x2="-266.7" y2="-60.96" width="0.1524" layer="91"/>
<wire x1="-266.7" y1="-60.96" x2="-246.38" y2="-60.96" width="0.1524" layer="91"/>
<junction x="-246.38" y="-60.96"/>
<pinref part="U1" gate="BGND" pin="GND14"/>
<wire x1="-246.38" y1="-53.34" x2="-246.38" y2="-50.8" width="0.1524" layer="91"/>
<junction x="-246.38" y="-53.34"/>
<pinref part="U$3" gate="G$1" pin="T"/>
<wire x1="-241.3" y1="-53.34" x2="-246.38" y2="-53.34" width="0.1524" layer="91"/>
<pinref part="U1" gate="BGND" pin="GND0"/>
<pinref part="U1" gate="BGND" pin="GND1"/>
<pinref part="U1" gate="BGND" pin="GND2"/>
<pinref part="U1" gate="BGND" pin="GND3"/>
<pinref part="U1" gate="BGND" pin="GND4"/>
<pinref part="U1" gate="BGND" pin="GND5"/>
<wire x1="-246.38" y1="-27.94" x2="-246.38" y2="-25.4" width="0.1524" layer="91"/>
<junction x="-246.38" y="-25.4"/>
<wire x1="-246.38" y1="-25.4" x2="-246.38" y2="-22.86" width="0.1524" layer="91"/>
<junction x="-246.38" y="-22.86"/>
<wire x1="-246.38" y1="-22.86" x2="-246.38" y2="-20.32" width="0.1524" layer="91"/>
<junction x="-246.38" y="-20.32"/>
<wire x1="-246.38" y1="-20.32" x2="-246.38" y2="-17.78" width="0.1524" layer="91"/>
<junction x="-246.38" y="-17.78"/>
<wire x1="-246.38" y1="-17.78" x2="-246.38" y2="-15.24" width="0.1524" layer="91"/>
<pinref part="U$5" gate="G$1" pin="T"/>
<wire x1="-243.84" y1="-25.4" x2="-246.38" y2="-25.4" width="0.1524" layer="91"/>
<wire x1="-246.38" y1="-15.24" x2="-246.38" y2="-10.16" width="0.1524" layer="91"/>
<junction x="-246.38" y="-15.24"/>
<wire x1="-246.38" y1="-10.16" x2="-261.62" y2="-10.16" width="0.1524" layer="91"/>
<pinref part="U$3" gate="G$1" pin="B"/>
<wire x1="-261.62" y1="-10.16" x2="-266.7" y2="-10.16" width="0.1524" layer="91"/>
<wire x1="-231.14" y1="-53.34" x2="-228.6" y2="-53.34" width="0.1524" layer="91"/>
<wire x1="-228.6" y1="-53.34" x2="-228.6" y2="-45.72" width="0.1524" layer="91"/>
<pinref part="U$5" gate="G$1" pin="B"/>
<wire x1="-228.6" y1="-45.72" x2="-228.6" y2="-30.48" width="0.1524" layer="91"/>
<wire x1="-228.6" y1="-30.48" x2="-228.6" y2="-25.4" width="0.1524" layer="91"/>
<wire x1="-228.6" y1="-25.4" x2="-233.68" y2="-25.4" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="B"/>
<wire x1="-233.68" y1="-30.48" x2="-228.6" y2="-30.48" width="0.1524" layer="91"/>
<junction x="-228.6" y="-30.48"/>
<pinref part="U$20" gate="G$1" pin="B"/>
<wire x1="-233.68" y1="-45.72" x2="-228.6" y2="-45.72" width="0.1524" layer="91"/>
<junction x="-228.6" y="-45.72"/>
<wire x1="-228.6" y1="-25.4" x2="-228.6" y2="-10.16" width="0.1524" layer="91"/>
<junction x="-228.6" y="-25.4"/>
<wire x1="-228.6" y1="-10.16" x2="-246.38" y2="-10.16" width="0.1524" layer="91"/>
<junction x="-246.38" y="-10.16"/>
<wire x1="-269.24" y1="86.36" x2="-284.48" y2="86.36" width="0.1524" layer="91"/>
<wire x1="-284.48" y1="86.36" x2="-340.36" y2="86.36" width="0.1524" layer="91"/>
<wire x1="-340.36" y1="86.36" x2="-340.36" y2="-2.54" width="0.1524" layer="91"/>
<wire x1="-340.36" y1="-2.54" x2="-261.62" y2="-2.54" width="0.1524" layer="91"/>
<wire x1="-261.62" y1="-2.54" x2="-261.62" y2="-10.16" width="0.1524" layer="91"/>
<junction x="-261.62" y="-10.16"/>
<pinref part="U$4" gate="G$1" pin="VSS"/>
<wire x1="-269.24" y1="81.28" x2="-269.24" y2="86.36" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="CE"/>
<wire x1="-284.48" y1="81.28" x2="-284.48" y2="86.36" width="0.1524" layer="91"/>
<junction x="-284.48" y="86.36"/>
</segment>
<segment>
<pinref part="U$8" gate="G$1" pin="GND"/>
<wire x1="-129.54" y1="-73.66" x2="-134.62" y2="-73.66" width="0.1524" layer="91"/>
<wire x1="-134.62" y1="-73.66" x2="-134.62" y2="-99.06" width="0.1524" layer="91"/>
<pinref part="U$9" gate="G$1" pin="GND"/>
<wire x1="-134.62" y1="-99.06" x2="-134.62" y2="-106.68" width="0.1524" layer="91"/>
<wire x1="-129.54" y1="-99.06" x2="-134.62" y2="-99.06" width="0.1524" layer="91"/>
<junction x="-134.62" y="-99.06"/>
<pinref part="SUPPLY10" gate="GND" pin="GND"/>
</segment>
<segment>
<pinref part="U1" gate="BVCCAUX" pin="M2"/>
<pinref part="U1" gate="BVCCAUX" pin="M1"/>
<wire x1="-88.9" y1="-17.78" x2="-88.9" y2="-15.24" width="0.1524" layer="91"/>
<pinref part="U1" gate="BVCCAUX" pin="M0"/>
<wire x1="-88.9" y1="-15.24" x2="-88.9" y2="-12.7" width="0.1524" layer="91"/>
<junction x="-88.9" y="-15.24"/>
<wire x1="-88.9" y1="-12.7" x2="-48.26" y2="-12.7" width="0.1524" layer="91"/>
<wire x1="-48.26" y1="-12.7" x2="-48.26" y2="-33.02" width="0.1524" layer="91"/>
<junction x="-88.9" y="-12.7"/>
<pinref part="IC1" gate="G$1" pin="GND"/>
<wire x1="-48.26" y1="-33.02" x2="-43.18" y2="-33.02" width="0.1524" layer="91"/>
<pinref part="SUPPLY8" gate="GND" pin="GND"/>
<wire x1="-43.18" y1="-33.02" x2="-27.94" y2="-33.02" width="0.1524" layer="91"/>
<wire x1="-43.18" y1="-38.1" x2="-43.18" y2="-33.02" width="0.1524" layer="91"/>
<junction x="-43.18" y="-33.02"/>
</segment>
</net>
<net name="N$3" class="0">
<segment>
<pinref part="U1" gate="B0AND1" pin="VCCO_TOP1"/>
<pinref part="U$10" gate="G$1" pin="T"/>
<wire x1="-111.76" y1="170.18" x2="-111.76" y2="167.64" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$14" class="0">
<segment>
<pinref part="U1" gate="B6AND7" pin="VCCO_LEFT2"/>
<pinref part="U$14" gate="G$1" pin="T"/>
</segment>
</net>
<net name="VCC" class="0">
<segment>
<pinref part="SUPPLY2" gate="G$1" pin="VCC"/>
<pinref part="U$14" gate="G$1" pin="B"/>
<pinref part="U$18" gate="G$1" pin="B"/>
<pinref part="U$15" gate="G$1" pin="B"/>
<wire x1="-190.5" y1="86.36" x2="-190.5" y2="88.9" width="0.1524" layer="91"/>
<wire x1="-190.5" y1="88.9" x2="-190.5" y2="91.44" width="0.1524" layer="91"/>
<junction x="-190.5" y="88.9"/>
<junction x="-190.5" y="91.44"/>
<wire x1="-190.5" y1="86.36" x2="-190.5" y2="83.82" width="0.1524" layer="91"/>
<junction x="-190.5" y="86.36"/>
<pinref part="U1" gate="B6AND7" pin="VCCO_LEFT0"/>
<pinref part="U$18" gate="G$1" pin="T"/>
<wire x1="-190.5" y1="83.82" x2="-180.34" y2="83.82" width="0.1524" layer="91"/>
<wire x1="-180.34" y1="83.82" x2="-180.34" y2="86.36" width="0.1524" layer="91"/>
<junction x="-180.34" y="86.36"/>
<wire x1="-213.36" y1="83.82" x2="-190.5" y2="83.82" width="0.1524" layer="91"/>
<junction x="-190.5" y="83.82"/>
<pinref part="U$4" gate="G$1" pin="VCC"/>
<wire x1="-271.78" y1="25.4" x2="-271.78" y2="12.7" width="0.1524" layer="91"/>
<wire x1="-271.78" y1="12.7" x2="-213.36" y2="12.7" width="0.1524" layer="91"/>
<wire x1="-213.36" y1="12.7" x2="-213.36" y2="83.82" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="U$7" gate="G$1" pin="B"/>
<pinref part="SUPPLY3" gate="G$1" pin="VCC"/>
<wire x1="-114.3" y1="180.34" x2="-114.3" y2="187.96" width="0.1524" layer="91"/>
<pinref part="U$10" gate="G$1" pin="B"/>
<wire x1="-114.3" y1="180.34" x2="-111.76" y2="180.34" width="0.1524" layer="91"/>
<junction x="-114.3" y="180.34"/>
<pinref part="U1" gate="B0AND1" pin="VCCO_TOP0"/>
<pinref part="U$7" gate="G$1" pin="T"/>
<wire x1="-114.3" y1="170.18" x2="-114.3" y2="167.64" width="0.1524" layer="91"/>
<wire x1="-114.3" y1="167.64" x2="-116.84" y2="167.64" width="0.1524" layer="91"/>
<wire x1="-116.84" y1="167.64" x2="-116.84" y2="180.34" width="0.1524" layer="91"/>
<junction x="-114.3" y="167.64"/>
<wire x1="-116.84" y1="180.34" x2="-114.3" y2="180.34" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="SUPPLY4" gate="G$1" pin="VCC"/>
<wire x1="-22.86" y1="93.98" x2="-22.86" y2="101.6" width="0.1524" layer="91"/>
<pinref part="U$29" gate="G$1" pin="B"/>
<wire x1="-38.1" y1="93.98" x2="-22.86" y2="93.98" width="0.1524" layer="91"/>
<junction x="-38.1" y="93.98"/>
<pinref part="U$28" gate="G$1" pin="B"/>
<wire x1="-38.1" y1="91.44" x2="-38.1" y2="93.98" width="0.1524" layer="91"/>
<junction x="-38.1" y="91.44"/>
<pinref part="U$27" gate="G$1" pin="B"/>
<wire x1="-38.1" y1="88.9" x2="-38.1" y2="91.44" width="0.1524" layer="91"/>
<junction x="-38.1" y="88.9"/>
<wire x1="-38.1" y1="86.36" x2="-38.1" y2="88.9" width="0.1524" layer="91"/>
<pinref part="U1" gate="B2AND3" pin="VCCO_RIGHT2"/>
<pinref part="U$27" gate="G$1" pin="T"/>
<junction x="-48.26" y="88.9"/>
<wire x1="-48.26" y1="88.9" x2="-48.26" y2="86.36" width="0.1524" layer="91"/>
<wire x1="-48.26" y1="86.36" x2="-38.1" y2="86.36" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="U$26" gate="G$1" pin="B"/>
<pinref part="U$25" gate="G$1" pin="B"/>
<junction x="-114.3" y="2.54"/>
<pinref part="SUPPLY7" gate="G$1" pin="VCC"/>
<wire x1="-106.68" y1="-2.54" x2="-114.3" y2="-2.54" width="0.1524" layer="91"/>
<wire x1="-114.3" y1="-2.54" x2="-114.3" y2="2.54" width="0.1524" layer="91"/>
<wire x1="-114.3" y1="2.54" x2="-111.76" y2="2.54" width="0.1524" layer="91"/>
<pinref part="U1" gate="B4AND5" pin="VCCO_BOTTOM0"/>
<pinref part="U$26" gate="G$1" pin="T"/>
<wire x1="-111.76" y1="12.7" x2="-111.76" y2="15.24" width="0.1524" layer="91"/>
<wire x1="-111.76" y1="12.7" x2="-109.22" y2="12.7" width="0.1524" layer="91"/>
<wire x1="-109.22" y1="12.7" x2="-109.22" y2="2.54" width="0.1524" layer="91"/>
<junction x="-111.76" y="12.7"/>
<wire x1="-109.22" y1="2.54" x2="-111.76" y2="2.54" width="0.1524" layer="91"/>
<junction x="-111.76" y="2.54"/>
</segment>
<segment>
<pinref part="U$19" gate="G$1" pin="B"/>
<pinref part="SUPPLY5" gate="G$1" pin="VCC"/>
<wire x1="-124.46" y1="-2.54" x2="-116.84" y2="-2.54" width="0.1524" layer="91"/>
<wire x1="-116.84" y1="-2.54" x2="-116.84" y2="-5.08" width="0.1524" layer="91"/>
<junction x="-116.84" y="-2.54"/>
<wire x1="-116.84" y1="-2.54" x2="-116.84" y2="2.54" width="0.1524" layer="91"/>
<pinref part="U1" gate="B4AND5" pin="VCCO_BOTTOM2"/>
<pinref part="U$19" gate="G$1" pin="T"/>
<wire x1="-116.84" y1="12.7" x2="-116.84" y2="15.24" width="0.1524" layer="91"/>
<wire x1="-116.84" y1="12.7" x2="-119.38" y2="12.7" width="0.1524" layer="91"/>
<wire x1="-119.38" y1="12.7" x2="-119.38" y2="2.54" width="0.1524" layer="91"/>
<junction x="-116.84" y="12.7"/>
<wire x1="-119.38" y1="2.54" x2="-116.84" y2="2.54" width="0.1524" layer="91"/>
<junction x="-116.84" y="2.54"/>
</segment>
<segment>
<pinref part="U$6" gate="G$1" pin="B"/>
<pinref part="SUPPLY6" gate="G$1" pin="VCC"/>
<wire x1="-109.22" y1="180.34" x2="-109.22" y2="185.42" width="0.1524" layer="91"/>
<wire x1="-109.22" y1="180.34" x2="-106.68" y2="180.34" width="0.1524" layer="91"/>
<wire x1="-106.68" y1="180.34" x2="-106.68" y2="167.64" width="0.1524" layer="91"/>
<junction x="-109.22" y="180.34"/>
<pinref part="U1" gate="B0AND1" pin="VCCO_TOP2"/>
<pinref part="U$6" gate="G$1" pin="T"/>
<wire x1="-109.22" y1="170.18" x2="-109.22" y2="167.64" width="0.1524" layer="91"/>
<wire x1="-106.68" y1="167.64" x2="-109.22" y2="167.64" width="0.1524" layer="91"/>
<junction x="-109.22" y="167.64"/>
</segment>
<segment>
<pinref part="U$9" gate="G$1" pin="VCC"/>
<wire x1="-129.54" y1="-91.44" x2="-139.7" y2="-91.44" width="0.1524" layer="91"/>
<wire x1="-139.7" y1="-91.44" x2="-139.7" y2="-66.04" width="0.1524" layer="91"/>
<pinref part="SUPPLY9" gate="G$1" pin="VCC"/>
<pinref part="U$8" gate="G$1" pin="VCC"/>
<wire x1="-139.7" y1="-66.04" x2="-139.7" y2="-48.26" width="0.1524" layer="91"/>
<wire x1="-129.54" y1="-66.04" x2="-139.7" y2="-66.04" width="0.1524" layer="91"/>
<junction x="-139.7" y="-66.04"/>
</segment>
</net>
<net name="N$15" class="0">
<segment>
<pinref part="U1" gate="B6AND7" pin="VCCO_LEFT1"/>
<pinref part="U$15" gate="G$1" pin="T"/>
</segment>
</net>
<net name="N$25" class="0">
<segment>
<pinref part="U1" gate="B4AND5" pin="VCCO_BOTTOM1"/>
<pinref part="U$25" gate="G$1" pin="T"/>
<wire x1="-114.3" y1="12.7" x2="-114.3" y2="15.24" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$26" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="VCCO"/>
<wire x1="-27.94" y1="-12.7" x2="-30.48" y2="-12.7" width="0.1524" layer="91"/>
<wire x1="-30.48" y1="-12.7" x2="-30.48" y2="-10.16" width="0.1524" layer="91"/>
<pinref part="IC1" gate="G$1" pin="VCCINT"/>
<wire x1="-30.48" y1="-10.16" x2="-30.48" y2="-7.62" width="0.1524" layer="91"/>
<wire x1="-27.94" y1="-10.16" x2="-30.48" y2="-10.16" width="0.1524" layer="91"/>
<junction x="-30.48" y="-10.16"/>
<pinref part="IC1" gate="G$1" pin="VCCJ"/>
<wire x1="-27.94" y1="-7.62" x2="-30.48" y2="-7.62" width="0.1524" layer="91"/>
<junction x="-30.48" y="-7.62"/>
<wire x1="-30.48" y1="-7.62" x2="-30.48" y2="99.06" width="0.1524" layer="91"/>
<pinref part="U1" gate="B2AND3" pin="VCCO_RIGHT0"/>
<pinref part="U$29" gate="G$1" pin="T"/>
<wire x1="-30.48" y1="99.06" x2="-48.26" y2="99.06" width="0.1524" layer="91"/>
<wire x1="-48.26" y1="99.06" x2="-48.26" y2="93.98" width="0.1524" layer="91"/>
<junction x="-48.26" y="93.98"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="U1" gate="BGND" pin="GND13"/>
<pinref part="U1" gate="BGND" pin="GND12"/>
<wire x1="-246.38" y1="-48.26" x2="-246.38" y2="-45.72" width="0.1524" layer="91"/>
<pinref part="U1" gate="BGND" pin="GND11"/>
<wire x1="-246.38" y1="-45.72" x2="-246.38" y2="-43.18" width="0.1524" layer="91"/>
<junction x="-246.38" y="-45.72"/>
<pinref part="U1" gate="BGND" pin="GND10"/>
<wire x1="-246.38" y1="-43.18" x2="-246.38" y2="-40.64" width="0.1524" layer="91"/>
<junction x="-246.38" y="-43.18"/>
<pinref part="U1" gate="BGND" pin="GND9"/>
<wire x1="-246.38" y1="-40.64" x2="-246.38" y2="-38.1" width="0.1524" layer="91"/>
<junction x="-246.38" y="-40.64"/>
<pinref part="U1" gate="BGND" pin="GND8"/>
<wire x1="-246.38" y1="-38.1" x2="-246.38" y2="-35.56" width="0.1524" layer="91"/>
<junction x="-246.38" y="-38.1"/>
<pinref part="U1" gate="BGND" pin="GND7"/>
<wire x1="-246.38" y1="-35.56" x2="-246.38" y2="-33.02" width="0.1524" layer="91"/>
<junction x="-246.38" y="-35.56"/>
<pinref part="U1" gate="BGND" pin="GND6"/>
<wire x1="-246.38" y1="-30.48" x2="-246.38" y2="-33.02" width="0.1524" layer="91"/>
<junction x="-246.38" y="-33.02"/>
<pinref part="U$2" gate="G$1" pin="T"/>
<wire x1="-243.84" y1="-30.48" x2="-246.38" y2="-30.48" width="0.1524" layer="91"/>
<junction x="-246.38" y="-30.48"/>
<pinref part="U$20" gate="G$1" pin="T"/>
<wire x1="-243.84" y1="-45.72" x2="-246.38" y2="-45.72" width="0.1524" layer="91"/>
</segment>
</net>
<net name="TCK" class="0">
<segment>
<wire x1="-38.1" y1="27.94" x2="43.18" y2="27.94" width="0.1524" layer="91"/>
<label x="38.1" y="27.94" size="1.778" layer="95"/>
<pinref part="R1" gate="G$1" pin="2"/>
<pinref part="IC1" gate="G$1" pin="TCK"/>
<wire x1="-76.2" y1="-22.86" x2="-38.1" y2="-22.86" width="0.1524" layer="91"/>
<wire x1="-38.1" y1="-22.86" x2="-27.94" y2="-22.86" width="0.1524" layer="91"/>
<wire x1="-38.1" y1="27.94" x2="-38.1" y2="-22.86" width="0.1524" layer="91"/>
<junction x="-38.1" y="-22.86"/>
<pinref part="SV1" gate="1" pin="4"/>
</segment>
</net>
<net name="TMS" class="0">
<segment>
<wire x1="-33.02" y1="25.4" x2="43.18" y2="25.4" width="0.1524" layer="91"/>
<label x="38.1" y="25.4" size="1.778" layer="95"/>
<pinref part="R3" gate="G$1" pin="2"/>
<pinref part="IC1" gate="G$1" pin="TMS"/>
<wire x1="-76.2" y1="-30.48" x2="-33.02" y2="-30.48" width="0.1524" layer="91"/>
<wire x1="-33.02" y1="25.4" x2="-33.02" y2="-20.32" width="0.1524" layer="91"/>
<wire x1="-33.02" y1="-20.32" x2="-33.02" y2="-30.48" width="0.1524" layer="91"/>
<wire x1="-27.94" y1="-20.32" x2="-33.02" y2="-20.32" width="0.1524" layer="91"/>
<junction x="-33.02" y="-20.32"/>
<pinref part="SV1" gate="1" pin="5"/>
</segment>
</net>
<net name="TDI" class="0">
<segment>
<label x="38.1" y="30.48" size="1.778" layer="95"/>
<pinref part="IC1" gate="G$1" pin="TDI"/>
<wire x1="-35.56" y1="30.48" x2="43.18" y2="30.48" width="0.1524" layer="91"/>
<wire x1="-27.94" y1="-17.78" x2="-35.56" y2="-17.78" width="0.1524" layer="91"/>
<wire x1="-35.56" y1="-17.78" x2="-35.56" y2="30.48" width="0.1524" layer="91"/>
<pinref part="SV1" gate="1" pin="3"/>
</segment>
</net>
<net name="TDO" class="0">
<segment>
<label x="38.1" y="22.86" size="1.778" layer="95"/>
<wire x1="-88.9" y1="-27.94" x2="-40.64" y2="-27.94" width="0.1524" layer="91"/>
<wire x1="-40.64" y1="-27.94" x2="-40.64" y2="22.86" width="0.1524" layer="91"/>
<wire x1="-40.64" y1="22.86" x2="43.18" y2="22.86" width="0.1524" layer="91"/>
<pinref part="U1" gate="BVCCAUX" pin="TDO"/>
<pinref part="SV1" gate="1" pin="6"/>
</segment>
</net>
<net name="N$9" class="0">
<segment>
<pinref part="U1" gate="B4" pin="IO_L27N_4DIND0"/>
<pinref part="IC1" gate="G$1" pin="DO"/>
<wire x1="7.62" y1="-7.62" x2="7.62" y2="7.62" width="0.1524" layer="91"/>
<wire x1="7.62" y1="7.62" x2="-83.82" y2="7.62" width="0.1524" layer="91"/>
<wire x1="-83.82" y1="7.62" x2="-83.82" y2="15.24" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$8" class="0">
<segment>
<pinref part="U1" gate="BVCCAUX" pin="TCK"/>
<pinref part="R1" gate="G$1" pin="1"/>
<wire x1="-88.9" y1="-22.86" x2="-86.36" y2="-22.86" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$12" class="0">
<segment>
<pinref part="U1" gate="BVCCAUX" pin="TDI"/>
<pinref part="R2" gate="G$1" pin="1"/>
<wire x1="-88.9" y1="-25.4" x2="-76.2" y2="-25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$13" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="TDO"/>
<wire x1="7.62" y1="-33.02" x2="10.16" y2="-33.02" width="0.1524" layer="91"/>
<wire x1="10.16" y1="-33.02" x2="10.16" y2="-50.8" width="0.1524" layer="91"/>
<wire x1="10.16" y1="-50.8" x2="-58.42" y2="-50.8" width="0.1524" layer="91"/>
<wire x1="-58.42" y1="-50.8" x2="-58.42" y2="-25.4" width="0.1524" layer="91"/>
<pinref part="R2" gate="G$1" pin="2"/>
<wire x1="-58.42" y1="-25.4" x2="-66.04" y2="-25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$16" class="0">
<segment>
<pinref part="U1" gate="BVCCAUX" pin="TMS"/>
<pinref part="R3" gate="G$1" pin="1"/>
<wire x1="-88.9" y1="-30.48" x2="-86.36" y2="-30.48" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$18" class="0">
<segment>
<pinref part="U1" gate="B4" pin="IO_L31N_4INIT_B"/>
<wire x1="-81.28" y1="15.24" x2="-81.28" y2="0" width="0.1524" layer="91"/>
<wire x1="-81.28" y1="0" x2="10.16" y2="0" width="0.1524" layer="91"/>
<wire x1="10.16" y1="0" x2="10.16" y2="-25.4" width="0.1524" layer="91"/>
<pinref part="IC1" gate="G$1" pin="OE/RESET"/>
<wire x1="10.16" y1="-25.4" x2="7.62" y2="-25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$19" class="0">
<segment>
<pinref part="U1" gate="BVCCAUX" pin="CCLK"/>
<wire x1="-83.82" y1="2.54" x2="12.7" y2="2.54" width="0.1524" layer="91"/>
<wire x1="12.7" y1="2.54" x2="12.7" y2="-17.78" width="0.1524" layer="91"/>
<pinref part="IC1" gate="G$1" pin="CLK"/>
<wire x1="12.7" y1="-17.78" x2="7.62" y2="-17.78" width="0.1524" layer="91"/>
<wire x1="-83.82" y1="2.54" x2="-83.82" y2="-5.08" width="0.1524" layer="91"/>
<wire x1="-83.82" y1="-5.08" x2="-88.9" y2="-5.08" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$20" class="0">
<segment>
<pinref part="U1" gate="BVCCAUX" pin="DONE"/>
<wire x1="-88.9" y1="-7.62" x2="-86.36" y2="-7.62" width="0.1524" layer="91"/>
<wire x1="-86.36" y1="-7.62" x2="-86.36" y2="5.08" width="0.1524" layer="91"/>
<wire x1="-86.36" y1="5.08" x2="22.86" y2="5.08" width="0.1524" layer="91"/>
<pinref part="U$13" gate="G$1" pin="T"/>
</segment>
</net>
<net name="N$17" class="0">
<segment>
<pinref part="U1" gate="BVCCAUX" pin="PROG_B"/>
<wire x1="-88.9" y1="-20.32" x2="-43.18" y2="-20.32" width="0.1524" layer="91"/>
<wire x1="-43.18" y1="-20.32" x2="-43.18" y2="12.7" width="0.1524" layer="91"/>
<wire x1="-43.18" y1="12.7" x2="20.32" y2="12.7" width="0.1524" layer="91"/>
<wire x1="20.32" y1="12.7" x2="20.32" y2="-27.94" width="0.1524" layer="91"/>
<pinref part="IC1" gate="G$1" pin="/CF"/>
<wire x1="20.32" y1="-27.94" x2="7.62" y2="-27.94" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$28" class="0">
<segment>
<wire x1="-45.72" y1="91.44" x2="-45.72" y2="96.52" width="0.1524" layer="91"/>
<pinref part="U1" gate="B2AND3" pin="VCCO_RIGHT1"/>
<pinref part="U$28" gate="G$1" pin="T"/>
<wire x1="-48.26" y1="91.44" x2="-45.72" y2="91.44" width="0.1524" layer="91"/>
<junction x="-48.26" y="91.44"/>
</segment>
</net>
<net name="N$1" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L01P_7VRN_7"/>
<wire x1="-180.34" y1="104.14" x2="-251.46" y2="104.14" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="A3"/>
<wire x1="-251.46" y1="104.14" x2="-251.46" y2="81.28" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L01N_7VRP_7"/>
<wire x1="-254" y1="106.68" x2="-180.34" y2="106.68" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="A2"/>
<wire x1="-254" y1="106.68" x2="-254" y2="81.28" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$7" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L20N_7"/>
<wire x1="-180.34" y1="111.76" x2="-261.62" y2="111.76" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="DQ0"/>
<wire x1="-261.62" y1="111.76" x2="-261.62" y2="81.28" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$10" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L21P_7"/>
<wire x1="-180.34" y1="114.3" x2="-264.16" y2="114.3" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="DQ1"/>
<wire x1="-264.16" y1="114.3" x2="-264.16" y2="81.28" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$11" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L21N_7"/>
<wire x1="-180.34" y1="116.84" x2="-266.7" y2="116.84" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="DQ2"/>
<wire x1="-266.7" y1="116.84" x2="-266.7" y2="81.28" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$22" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L22P_7"/>
<wire x1="-180.34" y1="119.38" x2="-271.78" y2="119.38" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="DQ3"/>
<wire x1="-271.78" y1="119.38" x2="-271.78" y2="81.28" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$23" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L22N_7"/>
<wire x1="-180.34" y1="121.92" x2="-274.32" y2="121.92" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="DQ4"/>
<wire x1="-274.32" y1="121.92" x2="-274.32" y2="81.28" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$5" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L23P_7"/>
<wire x1="-180.34" y1="124.46" x2="-276.86" y2="124.46" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="DQ5"/>
<wire x1="-276.86" y1="124.46" x2="-276.86" y2="81.28" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$6" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L23N_7"/>
<wire x1="-180.34" y1="127" x2="-279.4" y2="127" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="DQ6"/>
<wire x1="-279.4" y1="127" x2="-279.4" y2="81.28" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$24" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L24P_7"/>
<wire x1="-180.34" y1="129.54" x2="-281.94" y2="129.54" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="DQ7"/>
<wire x1="-281.94" y1="129.54" x2="-281.94" y2="81.28" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$27" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L24N_7"/>
<wire x1="-180.34" y1="132.08" x2="-287.02" y2="132.08" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="A10"/>
<wire x1="-287.02" y1="132.08" x2="-287.02" y2="81.28" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$29" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L40P_7"/>
<wire x1="-180.34" y1="134.62" x2="-289.56" y2="134.62" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="OE"/>
<wire x1="-289.56" y1="134.62" x2="-289.56" y2="81.28" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$48" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L20P_7"/>
<wire x1="-180.34" y1="109.22" x2="-259.08" y2="109.22" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="A0"/>
<wire x1="-259.08" y1="109.22" x2="-259.08" y2="81.28" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$49" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IOVREF_7"/>
<pinref part="U$4" gate="G$1" pin="A1"/>
<wire x1="-180.34" y1="139.7" x2="-256.54" y2="139.7" width="0.1524" layer="91"/>
<wire x1="-256.54" y1="139.7" x2="-256.54" y2="81.28" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$50" class="0">
<segment>
<pinref part="U1" gate="B7" pin="IO_L40N_7VREF_7"/>
<wire x1="-180.34" y1="137.16" x2="-294.64" y2="137.16" width="0.1524" layer="91"/>
<wire x1="-294.64" y1="137.16" x2="-294.64" y2="25.4" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="A11"/>
<wire x1="-294.64" y1="25.4" x2="-289.56" y2="25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$52" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L24P_6"/>
<wire x1="-180.34" y1="66.04" x2="-302.26" y2="66.04" width="0.1524" layer="91"/>
<wire x1="-302.26" y1="66.04" x2="-302.26" y2="17.78" width="0.1524" layer="91"/>
<wire x1="-302.26" y1="17.78" x2="-281.94" y2="17.78" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="A13"/>
<wire x1="-281.94" y1="17.78" x2="-281.94" y2="25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$53" class="0">
<segment>
<wire x1="-299.72" y1="20.32" x2="-284.48" y2="20.32" width="0.1524" layer="91"/>
<pinref part="U1" gate="B6" pin="IO_L40N_6"/>
<wire x1="-180.34" y1="68.58" x2="-299.72" y2="68.58" width="0.1524" layer="91"/>
<wire x1="-299.72" y1="68.58" x2="-299.72" y2="20.32" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="A8"/>
<wire x1="-284.48" y1="20.32" x2="-284.48" y2="25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$54" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L24N_6VREF_6"/>
<wire x1="-180.34" y1="71.12" x2="-304.8" y2="71.12" width="0.1524" layer="91"/>
<wire x1="-304.8" y1="71.12" x2="-304.8" y2="15.24" width="0.1524" layer="91"/>
<wire x1="-304.8" y1="15.24" x2="-284.48" y2="15.24" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="WE"/>
<wire x1="-284.48" y1="15.24" x2="-281.94" y2="15.24" width="0.1524" layer="91"/>
<wire x1="-281.94" y1="15.24" x2="-279.4" y2="15.24" width="0.1524" layer="91"/>
<wire x1="-279.4" y1="15.24" x2="-279.4" y2="25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$55" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L23P_6"/>
<wire x1="-180.34" y1="60.96" x2="-307.34" y2="60.96" width="0.1524" layer="91"/>
<wire x1="-307.34" y1="60.96" x2="-307.34" y2="12.7" width="0.1524" layer="91"/>
<wire x1="-307.34" y1="12.7" x2="-276.86" y2="12.7" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="A17"/>
<wire x1="-276.86" y1="12.7" x2="-276.86" y2="25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$56" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L23N_6"/>
<wire x1="-180.34" y1="63.5" x2="-309.88" y2="63.5" width="0.1524" layer="91"/>
<wire x1="-309.88" y1="63.5" x2="-309.88" y2="10.16" width="0.1524" layer="91"/>
<wire x1="-309.88" y1="10.16" x2="-274.32" y2="10.16" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="A15"/>
<wire x1="-274.32" y1="10.16" x2="-274.32" y2="25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$33" class="0">
<segment>
<wire x1="-287.02" y1="22.86" x2="-297.18" y2="22.86" width="0.1524" layer="91"/>
<wire x1="-297.18" y1="22.86" x2="-297.18" y2="73.66" width="0.1524" layer="91"/>
<pinref part="U1" gate="B6" pin="IO_L40P_6VREF_6"/>
<wire x1="-180.34" y1="73.66" x2="-297.18" y2="73.66" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="A9"/>
<wire x1="-287.02" y1="22.86" x2="-287.02" y2="25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$36" class="0">
<segment>
<wire x1="-312.42" y1="7.62" x2="-269.24" y2="7.62" width="0.1524" layer="91"/>
<pinref part="U1" gate="B6" pin="IO_L22P_6"/>
<wire x1="-180.34" y1="55.88" x2="-312.42" y2="55.88" width="0.1524" layer="91"/>
<wire x1="-312.42" y1="55.88" x2="-312.42" y2="7.62" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="A18"/>
<wire x1="-269.24" y1="7.62" x2="-269.24" y2="25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$30" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L22N_6"/>
<pinref part="U$4" gate="G$1" pin="A16"/>
<wire x1="-180.34" y1="58.42" x2="-266.7" y2="58.42" width="0.1524" layer="91"/>
<wire x1="-266.7" y1="58.42" x2="-266.7" y2="25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$31" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L21P_6"/>
<pinref part="U$4" gate="G$1" pin="A14"/>
<wire x1="-180.34" y1="50.8" x2="-264.16" y2="50.8" width="0.1524" layer="91"/>
<wire x1="-264.16" y1="50.8" x2="-264.16" y2="25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$32" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L21N_6"/>
<pinref part="U$4" gate="G$1" pin="A12"/>
<wire x1="-180.34" y1="53.34" x2="-261.62" y2="53.34" width="0.1524" layer="91"/>
<wire x1="-261.62" y1="53.34" x2="-261.62" y2="25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$34" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L20P_6"/>
<pinref part="U$4" gate="G$1" pin="A7"/>
<wire x1="-180.34" y1="45.72" x2="-259.08" y2="45.72" width="0.1524" layer="91"/>
<wire x1="-259.08" y1="45.72" x2="-259.08" y2="25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$35" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L20N_6"/>
<pinref part="U$4" gate="G$1" pin="A6"/>
<wire x1="-180.34" y1="48.26" x2="-256.54" y2="48.26" width="0.1524" layer="91"/>
<wire x1="-256.54" y1="48.26" x2="-256.54" y2="25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$37" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L01P_6VRN_6"/>
<wire x1="-180.34" y1="40.64" x2="-251.46" y2="40.64" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="A4"/>
<wire x1="-251.46" y1="40.64" x2="-251.46" y2="25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$38" class="0">
<segment>
<pinref part="U1" gate="B6" pin="IO_L01N_6VRP_6"/>
<wire x1="-180.34" y1="43.18" x2="-254" y2="43.18" width="0.1524" layer="91"/>
<pinref part="U$4" gate="G$1" pin="A5"/>
<wire x1="-254" y1="43.18" x2="-254" y2="25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$39" class="0">
<segment>
<pinref part="U$8" gate="G$1" pin="VOUT1"/>
<wire x1="-99.06" y1="-66.04" x2="-76.2" y2="-66.04" width="0.1524" layer="91"/>
<pinref part="U$11" gate="G$1" pin="B"/>
<wire x1="-76.2" y1="-50.8" x2="-76.2" y2="-66.04" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$40" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="/CE"/>
<wire x1="22.86" y1="-20.32" x2="7.62" y2="-20.32" width="0.1524" layer="91"/>
<pinref part="U$12" gate="G$1" pin="T"/>
</segment>
</net>
<net name="N$41" class="0">
<segment>
<pinref part="U$13" gate="G$1" pin="B"/>
<pinref part="U$12" gate="G$1" pin="B"/>
<wire x1="22.86" y1="-5.08" x2="22.86" y2="-10.16" width="0.1524" layer="91"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
</eagle>