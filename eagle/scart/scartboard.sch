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
<library name="con-hirschmann">
<description>&lt;b&gt;Hirschmann Connectors&lt;/b&gt;&lt;p&gt;
Audio, scart, microphone, headphone&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="SCART-F">
<description>TV SCART &lt;B&gt;CONNECTOR&lt;/B&gt;</description>
<wire x1="-23.495" y1="-11.049" x2="23.495" y2="-11.049" width="0.1524" layer="21"/>
<wire x1="23.495" y1="-11.049" x2="23.495" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="23.495" y1="-3.048" x2="33.02" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="33.02" y1="-3.048" x2="33.02" y2="0" width="0.1524" layer="21"/>
<wire x1="33.02" y1="0" x2="23.495" y2="0" width="0.1524" layer="21"/>
<wire x1="23.495" y1="0" x2="20.066" y2="0" width="0.1524" layer="21"/>
<wire x1="20.066" y1="0" x2="18.669" y2="0" width="0.1524" layer="21"/>
<wire x1="23.495" y1="-3.048" x2="23.495" y2="0" width="0.1524" layer="21"/>
<wire x1="22.479" y1="-0.381" x2="22.479" y2="-10.668" width="0.0508" layer="21"/>
<wire x1="20.066" y1="0" x2="20.066" y2="3.81" width="0.1524" layer="21"/>
<wire x1="18.669" y1="6.985" x2="18.034" y2="6.35" width="0.1524" layer="21"/>
<wire x1="20.066" y1="6.35" x2="19.431" y2="6.985" width="0.1524" layer="21"/>
<wire x1="20.066" y1="3.81" x2="20.066" y2="6.35" width="0.1524" layer="51"/>
<wire x1="18.034" y1="6.35" x2="18.034" y2="3.81" width="0.1524" layer="51"/>
<wire x1="18.034" y1="3.81" x2="18.034" y2="2.667" width="0.1524" layer="21"/>
<wire x1="18.034" y1="2.667" x2="17.526" y2="2.159" width="0.1524" layer="21"/>
<wire x1="17.526" y1="2.159" x2="17.526" y2="1.524" width="0.1524" layer="21"/>
<wire x1="16.764" y1="1.524" x2="16.764" y2="2.159" width="0.1524" layer="21"/>
<wire x1="16.764" y1="2.159" x2="16.256" y2="2.667" width="0.1524" layer="21"/>
<wire x1="16.256" y1="2.667" x2="16.256" y2="3.81" width="0.1524" layer="21"/>
<wire x1="16.256" y1="3.81" x2="16.256" y2="6.35" width="0.1524" layer="51"/>
<wire x1="16.256" y1="6.35" x2="15.621" y2="6.985" width="0.1524" layer="21"/>
<wire x1="15.621" y1="6.985" x2="14.859" y2="6.985" width="0.1524" layer="21"/>
<wire x1="14.859" y1="6.985" x2="14.224" y2="6.35" width="0.1524" layer="21"/>
<wire x1="14.224" y1="6.35" x2="14.224" y2="3.81" width="0.1524" layer="51"/>
<wire x1="14.224" y1="3.81" x2="14.224" y2="2.667" width="0.1524" layer="21"/>
<wire x1="18.669" y1="6.985" x2="19.431" y2="6.985" width="0.1524" layer="21"/>
<wire x1="14.224" y1="2.667" x2="13.716" y2="2.159" width="0.1524" layer="21"/>
<wire x1="12.954" y1="2.159" x2="12.446" y2="2.667" width="0.1524" layer="21"/>
<wire x1="12.446" y1="2.667" x2="12.446" y2="3.81" width="0.1524" layer="21"/>
<wire x1="12.446" y1="3.81" x2="12.446" y2="6.35" width="0.1524" layer="51"/>
<wire x1="13.716" y1="2.159" x2="13.716" y2="1.524" width="0.1524" layer="21"/>
<wire x1="12.954" y1="1.524" x2="12.954" y2="2.159" width="0.1524" layer="21"/>
<wire x1="17.526" y1="1.524" x2="16.764" y2="1.524" width="0.1524" layer="21"/>
<wire x1="13.716" y1="1.524" x2="12.954" y2="1.524" width="0.1524" layer="21"/>
<wire x1="15.621" y1="0" x2="14.859" y2="0" width="0.1524" layer="21"/>
<wire x1="15.621" y1="0" x2="18.669" y2="0" width="0.1524" layer="51"/>
<wire x1="11.811" y1="0" x2="11.049" y2="0" width="0.1524" layer="21"/>
<wire x1="11.811" y1="0" x2="14.859" y2="0" width="0.1524" layer="51"/>
<wire x1="12.446" y1="6.35" x2="11.811" y2="6.985" width="0.1524" layer="21"/>
<wire x1="11.811" y1="6.985" x2="11.049" y2="6.985" width="0.1524" layer="21"/>
<wire x1="11.049" y1="6.985" x2="10.414" y2="6.35" width="0.1524" layer="21"/>
<wire x1="10.414" y1="6.35" x2="10.414" y2="3.81" width="0.1524" layer="51"/>
<wire x1="10.414" y1="3.81" x2="10.414" y2="2.667" width="0.1524" layer="21"/>
<wire x1="10.414" y1="2.667" x2="9.906" y2="2.159" width="0.1524" layer="21"/>
<wire x1="9.906" y1="2.159" x2="9.906" y2="1.524" width="0.1524" layer="21"/>
<wire x1="9.906" y1="1.524" x2="9.144" y2="1.524" width="0.1524" layer="21"/>
<wire x1="9.144" y1="1.524" x2="9.144" y2="2.159" width="0.1524" layer="21"/>
<wire x1="9.144" y1="2.159" x2="8.636" y2="2.667" width="0.1524" layer="21"/>
<wire x1="8.636" y1="2.667" x2="8.636" y2="3.81" width="0.1524" layer="21"/>
<wire x1="8.636" y1="3.81" x2="8.636" y2="6.35" width="0.1524" layer="51"/>
<wire x1="8.636" y1="6.35" x2="8.001" y2="6.985" width="0.1524" layer="21"/>
<wire x1="8.001" y1="6.985" x2="7.239" y2="6.985" width="0.1524" layer="21"/>
<wire x1="7.239" y1="6.985" x2="6.604" y2="6.35" width="0.1524" layer="21"/>
<wire x1="6.604" y1="6.35" x2="6.604" y2="3.81" width="0.1524" layer="51"/>
<wire x1="6.604" y1="3.81" x2="6.604" y2="2.667" width="0.1524" layer="21"/>
<wire x1="6.604" y1="2.667" x2="6.096" y2="2.159" width="0.1524" layer="21"/>
<wire x1="6.096" y1="2.159" x2="6.096" y2="1.524" width="0.1524" layer="21"/>
<wire x1="6.096" y1="1.524" x2="5.334" y2="1.524" width="0.1524" layer="21"/>
<wire x1="5.334" y1="1.524" x2="5.334" y2="2.159" width="0.1524" layer="21"/>
<wire x1="5.334" y1="2.159" x2="4.826" y2="2.667" width="0.1524" layer="21"/>
<wire x1="4.826" y1="2.667" x2="4.826" y2="3.81" width="0.1524" layer="21"/>
<wire x1="4.826" y1="3.81" x2="4.826" y2="6.35" width="0.1524" layer="51"/>
<wire x1="4.826" y1="6.35" x2="4.191" y2="6.985" width="0.1524" layer="21"/>
<wire x1="4.191" y1="6.985" x2="3.429" y2="6.985" width="0.1524" layer="21"/>
<wire x1="3.429" y1="6.985" x2="2.794" y2="6.35" width="0.1524" layer="21"/>
<wire x1="2.794" y1="6.35" x2="2.794" y2="3.81" width="0.1524" layer="51"/>
<wire x1="2.794" y1="3.81" x2="2.794" y2="2.667" width="0.1524" layer="21"/>
<wire x1="2.794" y1="2.667" x2="2.286" y2="2.159" width="0.1524" layer="21"/>
<wire x1="2.286" y1="2.159" x2="2.286" y2="1.524" width="0.1524" layer="21"/>
<wire x1="2.286" y1="1.524" x2="1.524" y2="1.524" width="0.1524" layer="21"/>
<wire x1="1.524" y1="1.524" x2="1.524" y2="2.159" width="0.1524" layer="21"/>
<wire x1="1.524" y1="2.159" x2="1.016" y2="2.667" width="0.1524" layer="21"/>
<wire x1="1.016" y1="2.667" x2="1.016" y2="3.81" width="0.1524" layer="21"/>
<wire x1="1.016" y1="3.81" x2="1.016" y2="6.35" width="0.1524" layer="51"/>
<wire x1="8.001" y1="0" x2="7.239" y2="0" width="0.1524" layer="21"/>
<wire x1="4.191" y1="0" x2="3.429" y2="0" width="0.1524" layer="21"/>
<wire x1="0.381" y1="0" x2="-0.381" y2="0" width="0.1524" layer="21"/>
<wire x1="8.001" y1="0" x2="11.049" y2="0" width="0.1524" layer="51"/>
<wire x1="4.191" y1="0" x2="7.239" y2="0" width="0.1524" layer="51"/>
<wire x1="0.381" y1="0" x2="3.429" y2="0" width="0.1524" layer="51"/>
<wire x1="1.016" y1="6.35" x2="0.381" y2="6.985" width="0.1524" layer="21"/>
<wire x1="0.381" y1="6.985" x2="-0.381" y2="6.985" width="0.1524" layer="21"/>
<wire x1="-0.381" y1="6.985" x2="-1.016" y2="6.35" width="0.1524" layer="21"/>
<wire x1="-1.016" y1="6.35" x2="-1.016" y2="3.81" width="0.1524" layer="51"/>
<wire x1="-1.016" y1="3.81" x2="-1.016" y2="2.667" width="0.1524" layer="21"/>
<wire x1="-1.016" y1="2.667" x2="-1.524" y2="2.159" width="0.1524" layer="21"/>
<wire x1="-1.524" y1="2.159" x2="-1.524" y2="1.524" width="0.1524" layer="21"/>
<wire x1="-1.524" y1="1.524" x2="-2.286" y2="1.524" width="0.1524" layer="21"/>
<wire x1="-2.286" y1="1.524" x2="-2.286" y2="2.159" width="0.1524" layer="21"/>
<wire x1="-2.286" y1="2.159" x2="-2.794" y2="2.667" width="0.1524" layer="21"/>
<wire x1="-2.794" y1="2.667" x2="-2.794" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-2.794" y1="3.81" x2="-2.794" y2="6.35" width="0.1524" layer="51"/>
<wire x1="-2.794" y1="6.35" x2="-3.429" y2="6.985" width="0.1524" layer="21"/>
<wire x1="-3.429" y1="6.985" x2="-4.191" y2="6.985" width="0.1524" layer="21"/>
<wire x1="-4.191" y1="6.985" x2="-4.826" y2="6.35" width="0.1524" layer="21"/>
<wire x1="-4.826" y1="6.35" x2="-4.826" y2="3.81" width="0.1524" layer="51"/>
<wire x1="-3.429" y1="0" x2="-4.191" y2="0" width="0.1524" layer="21"/>
<wire x1="-3.429" y1="0" x2="-0.381" y2="0" width="0.1524" layer="51"/>
<wire x1="-4.826" y1="3.81" x2="-4.826" y2="2.667" width="0.1524" layer="21"/>
<wire x1="-4.826" y1="2.667" x2="-5.334" y2="2.159" width="0.1524" layer="21"/>
<wire x1="-5.334" y1="2.159" x2="-5.334" y2="1.524" width="0.1524" layer="21"/>
<wire x1="-5.334" y1="1.524" x2="-6.096" y2="1.524" width="0.1524" layer="21"/>
<wire x1="-6.096" y1="1.524" x2="-6.096" y2="2.159" width="0.1524" layer="21"/>
<wire x1="-6.096" y1="2.159" x2="-6.604" y2="2.667" width="0.1524" layer="21"/>
<wire x1="-6.604" y1="2.667" x2="-6.604" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-6.604" y1="3.81" x2="-6.604" y2="6.35" width="0.1524" layer="51"/>
<wire x1="-6.604" y1="6.35" x2="-7.239" y2="6.985" width="0.1524" layer="21"/>
<wire x1="-7.239" y1="6.985" x2="-8.001" y2="6.985" width="0.1524" layer="21"/>
<wire x1="-8.001" y1="6.985" x2="-8.636" y2="6.35" width="0.1524" layer="21"/>
<wire x1="-8.636" y1="6.35" x2="-8.636" y2="3.81" width="0.1524" layer="51"/>
<wire x1="-8.636" y1="3.81" x2="-8.636" y2="2.667" width="0.1524" layer="21"/>
<wire x1="-8.636" y1="2.667" x2="-9.144" y2="2.159" width="0.1524" layer="21"/>
<wire x1="-9.144" y1="2.159" x2="-9.144" y2="1.524" width="0.1524" layer="21"/>
<wire x1="-9.144" y1="1.524" x2="-9.906" y2="1.524" width="0.1524" layer="21"/>
<wire x1="-9.906" y1="1.524" x2="-9.906" y2="2.159" width="0.1524" layer="21"/>
<wire x1="-9.906" y1="2.159" x2="-10.414" y2="2.667" width="0.1524" layer="21"/>
<wire x1="-10.414" y1="2.667" x2="-10.414" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-10.414" y1="3.81" x2="-10.414" y2="6.35" width="0.1524" layer="51"/>
<wire x1="-7.239" y1="0" x2="-8.001" y2="0" width="0.1524" layer="21"/>
<wire x1="-7.239" y1="0" x2="-4.191" y2="0" width="0.1524" layer="51"/>
<wire x1="-11.049" y1="0" x2="-8.001" y2="0" width="0.1524" layer="51"/>
<wire x1="-10.414" y1="6.35" x2="-11.049" y2="6.985" width="0.1524" layer="21"/>
<wire x1="-11.049" y1="6.985" x2="-11.811" y2="6.985" width="0.1524" layer="21"/>
<wire x1="-11.049" y1="0" x2="-11.811" y2="0" width="0.1524" layer="21"/>
<wire x1="-14.859" y1="0" x2="-15.621" y2="0" width="0.1524" layer="21"/>
<wire x1="-14.859" y1="0" x2="-11.811" y2="0" width="0.1524" layer="51"/>
<wire x1="-11.811" y1="6.985" x2="-12.446" y2="6.35" width="0.1524" layer="21"/>
<wire x1="-12.446" y1="6.35" x2="-12.446" y2="3.81" width="0.1524" layer="51"/>
<wire x1="-12.446" y1="3.81" x2="-12.446" y2="2.667" width="0.1524" layer="21"/>
<wire x1="-12.446" y1="2.667" x2="-12.954" y2="2.159" width="0.1524" layer="21"/>
<wire x1="-12.954" y1="2.159" x2="-12.954" y2="1.524" width="0.1524" layer="21"/>
<wire x1="-12.954" y1="1.524" x2="-13.716" y2="1.524" width="0.1524" layer="21"/>
<wire x1="-13.716" y1="1.524" x2="-13.716" y2="2.159" width="0.1524" layer="21"/>
<wire x1="-13.716" y1="2.159" x2="-14.224" y2="2.667" width="0.1524" layer="21"/>
<wire x1="-14.224" y1="2.667" x2="-14.224" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-14.224" y1="3.81" x2="-14.224" y2="6.35" width="0.1524" layer="51"/>
<wire x1="-14.224" y1="6.35" x2="-14.859" y2="6.985" width="0.1524" layer="21"/>
<wire x1="-14.859" y1="6.985" x2="-15.621" y2="6.985" width="0.1524" layer="21"/>
<wire x1="-15.621" y1="6.985" x2="-16.256" y2="6.35" width="0.1524" layer="21"/>
<wire x1="-16.256" y1="6.35" x2="-16.256" y2="3.81" width="0.1524" layer="51"/>
<wire x1="-16.256" y1="3.81" x2="-16.256" y2="2.667" width="0.1524" layer="21"/>
<wire x1="-16.256" y1="2.667" x2="-16.764" y2="2.159" width="0.1524" layer="21"/>
<wire x1="-16.764" y1="2.159" x2="-16.764" y2="1.524" width="0.1524" layer="21"/>
<wire x1="-16.764" y1="1.524" x2="-17.526" y2="1.524" width="0.1524" layer="21"/>
<wire x1="-17.526" y1="1.524" x2="-17.526" y2="2.159" width="0.1524" layer="21"/>
<wire x1="-17.526" y1="2.159" x2="-18.034" y2="2.667" width="0.1524" layer="21"/>
<wire x1="-18.034" y1="2.667" x2="-18.034" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-18.034" y1="3.81" x2="-18.034" y2="6.35" width="0.1524" layer="51"/>
<wire x1="-18.669" y1="0" x2="-15.621" y2="0" width="0.1524" layer="51"/>
<wire x1="-18.669" y1="0" x2="-20.066" y2="0" width="0.1524" layer="21"/>
<wire x1="-18.034" y1="6.35" x2="-18.669" y2="6.985" width="0.1524" layer="21"/>
<wire x1="-18.669" y1="6.985" x2="-19.431" y2="6.985" width="0.1524" layer="21"/>
<wire x1="-19.431" y1="6.985" x2="-20.066" y2="6.35" width="0.1524" layer="21"/>
<wire x1="-20.066" y1="6.35" x2="-20.066" y2="3.81" width="0.1524" layer="51"/>
<wire x1="-20.066" y1="0" x2="-20.066" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-20.066" y1="0" x2="-23.495" y2="0" width="0.1524" layer="21"/>
<wire x1="-23.495" y1="-3.048" x2="-23.495" y2="0" width="0.1524" layer="21"/>
<wire x1="-23.495" y1="0" x2="-33.02" y2="0" width="0.1524" layer="21"/>
<wire x1="-33.02" y1="-3.048" x2="-33.02" y2="0" width="0.1524" layer="21"/>
<wire x1="-33.02" y1="-3.048" x2="-23.495" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="-23.495" y1="-11.049" x2="-23.495" y2="-3.048" width="0.1524" layer="21"/>
<wire x1="-22.479" y1="-0.381" x2="-22.479" y2="-10.668" width="0.0508" layer="21"/>
<wire x1="29.21" y1="-4.064" x2="29.21" y2="1.016" width="0.1524" layer="21"/>
<wire x1="-29.21" y1="-4.064" x2="-29.21" y2="1.016" width="0.1524" layer="21"/>
<wire x1="24.892" y1="-3.302" x2="24.892" y2="0.254" width="0.0024" layer="20"/>
<wire x1="24.892" y1="-3.302" x2="27.94" y2="-3.302" width="0" layer="20" curve="180"/>
<wire x1="24.892" y1="0.254" x2="27.94" y2="0.254" width="0" layer="20" curve="-180"/>
<wire x1="27.94" y1="0.254" x2="27.94" y2="-3.302" width="0.0024" layer="20"/>
<wire x1="-27.94" y1="-3.302" x2="-27.94" y2="0.254" width="0.0024" layer="20"/>
<wire x1="-27.94" y1="-3.302" x2="-24.892" y2="-3.302" width="0" layer="20" curve="180"/>
<wire x1="-27.94" y1="0.254" x2="-24.892" y2="0.254" width="0" layer="20" curve="-180"/>
<wire x1="-24.892" y1="0.254" x2="-24.892" y2="-3.302" width="0.0024" layer="20"/>
<pad name="1" x="19.05" y="5.08" drill="1.3208" shape="long" rot="R90"/>
<pad name="2" x="17.145" y="0" drill="1.3208" shape="long" rot="R90"/>
<pad name="3" x="15.24" y="5.08" drill="1.3208" shape="long" rot="R90"/>
<pad name="4" x="13.335" y="0" drill="1.3208" shape="long" rot="R90"/>
<pad name="5" x="11.43" y="5.08" drill="1.3208" shape="long" rot="R90"/>
<pad name="6" x="9.525" y="0" drill="1.3208" shape="long" rot="R90"/>
<pad name="7" x="7.62" y="5.08" drill="1.3208" shape="long" rot="R90"/>
<pad name="8" x="5.715" y="0" drill="1.3208" shape="long" rot="R90"/>
<pad name="9" x="3.81" y="5.08" drill="1.3208" shape="long" rot="R90"/>
<pad name="10" x="1.905" y="0" drill="1.3208" shape="long" rot="R90"/>
<pad name="11" x="0" y="5.08" drill="1.3208" shape="long" rot="R90"/>
<pad name="12" x="-1.905" y="0" drill="1.3208" shape="long" rot="R90"/>
<pad name="13" x="-3.81" y="5.08" drill="1.3208" shape="long" rot="R90"/>
<pad name="14" x="-5.715" y="0" drill="1.3208" shape="long" rot="R90"/>
<pad name="15" x="-7.62" y="5.08" drill="1.3208" shape="long" rot="R90"/>
<pad name="16" x="-9.525" y="0" drill="1.3208" shape="long" rot="R90"/>
<pad name="17" x="-11.43" y="5.08" drill="1.3208" shape="long" rot="R90"/>
<pad name="18" x="-13.335" y="0" drill="1.3208" shape="long" rot="R90"/>
<pad name="19" x="-15.24" y="5.08" drill="1.3208" shape="long" rot="R90"/>
<pad name="20" x="-17.145" y="0" drill="1.3208" shape="long" rot="R90"/>
<pad name="21" x="-19.05" y="5.08" drill="1.3208" shape="long" rot="R90"/>
<text x="24.765" y="-7.112" size="1.778" layer="47" ratio="10">3,0</text>
<text x="19.939" y="-2.286" size="1.27" layer="21" ratio="10">1</text>
<text x="-29.845" y="3.048" size="1.778" layer="25" ratio="10">&gt;NAME</text>
<text x="-17.78" y="-10.16" size="1.778" layer="27" ratio="10">&gt;VALUE</text>
<text x="-21.336" y="-2.286" size="1.27" layer="21" ratio="10">21</text>
<text x="31.877" y="-7.62" size="1.778" layer="47" ratio="10" rot="R90">long</text>
<text x="-9.779" y="-5.08" size="1.778" layer="21" ratio="10">SCART-F</text>
<text x="-28.067" y="-7.112" size="1.778" layer="47" ratio="10">3,0 </text>
<text x="-29.083" y="-7.747" size="1.778" layer="47" ratio="10" rot="R90">long </text>
<hole x="26.416" y="0.254" drill="3.0226"/>
<hole x="26.416" y="-3.302" drill="3.0226"/>
<hole x="-26.416" y="0.254" drill="3.0226"/>
<hole x="-26.416" y="-3.302" drill="3.0226"/>
</package>
</packages>
<symbols>
<symbol name="SCART">
<wire x1="-1.905" y1="-26.035" x2="-2.54" y2="-25.4" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-2.54" y1="-25.4" x2="-1.905" y2="-24.765" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="1.905" y1="-17.145" x2="2.54" y2="-17.78" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="2.54" y1="-17.78" x2="1.905" y2="-18.415" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="1.905" y1="-22.225" x2="2.54" y2="-22.86" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="2.54" y1="-22.86" x2="1.905" y2="-23.495" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-1.905" y1="-15.875" x2="-2.54" y2="-15.24" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-2.54" y1="-15.24" x2="-1.905" y2="-14.605" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-5.08" y1="-27.94" x2="5.08" y2="-27.94" width="0.4064" layer="94"/>
<wire x1="-5.08" y1="-27.94" x2="-5.08" y2="-25.4" width="0.4064" layer="94"/>
<wire x1="-5.08" y1="-25.4" x2="-5.08" y2="-20.32" width="0.4064" layer="94"/>
<wire x1="-5.08" y1="-20.32" x2="-5.08" y2="-15.24" width="0.4064" layer="94"/>
<wire x1="-5.08" y1="-15.24" x2="-5.08" y2="-10.16" width="0.4064" layer="94"/>
<wire x1="-5.08" y1="-10.16" x2="-5.08" y2="-5.08" width="0.4064" layer="94"/>
<wire x1="-5.08" y1="-5.08" x2="-5.08" y2="0" width="0.4064" layer="94"/>
<wire x1="-5.08" y1="0" x2="-5.08" y2="5.08" width="0.4064" layer="94"/>
<wire x1="-5.08" y1="5.08" x2="-5.08" y2="10.16" width="0.4064" layer="94"/>
<wire x1="-5.08" y1="10.16" x2="-5.08" y2="15.24" width="0.4064" layer="94"/>
<wire x1="-5.08" y1="15.24" x2="-5.08" y2="20.32" width="0.4064" layer="94"/>
<wire x1="-5.08" y1="20.32" x2="-5.08" y2="25.4" width="0.4064" layer="94"/>
<wire x1="-5.08" y1="25.4" x2="-1.27" y2="25.4" width="0.4064" layer="94"/>
<wire x1="-1.27" y1="25.4" x2="5.08" y2="27.94" width="0.4064" layer="94"/>
<wire x1="5.08" y1="-27.94" x2="5.08" y2="-22.86" width="0.4064" layer="94"/>
<wire x1="5.08" y1="-22.86" x2="5.08" y2="-17.78" width="0.4064" layer="94"/>
<wire x1="5.08" y1="-17.78" x2="5.08" y2="-12.7" width="0.4064" layer="94"/>
<wire x1="5.08" y1="-12.7" x2="5.08" y2="-7.62" width="0.4064" layer="94"/>
<wire x1="5.08" y1="-7.62" x2="5.08" y2="-2.54" width="0.4064" layer="94"/>
<wire x1="5.08" y1="-2.54" x2="5.08" y2="2.54" width="0.4064" layer="94"/>
<wire x1="5.08" y1="2.54" x2="5.08" y2="7.62" width="0.4064" layer="94"/>
<wire x1="5.08" y1="7.62" x2="5.08" y2="12.7" width="0.4064" layer="94"/>
<wire x1="5.08" y1="12.7" x2="5.08" y2="17.78" width="0.4064" layer="94"/>
<wire x1="5.08" y1="17.78" x2="5.08" y2="22.86" width="0.4064" layer="94"/>
<wire x1="5.08" y1="22.86" x2="5.08" y2="27.94" width="0.4064" layer="94"/>
<wire x1="-1.905" y1="-20.955" x2="-2.54" y2="-20.32" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-2.54" y1="-20.32" x2="-1.905" y2="-19.685" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="1.905" y1="-12.065" x2="2.54" y2="-12.7" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="2.54" y1="-12.7" x2="1.905" y2="-13.335" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-1.905" y1="-10.795" x2="-2.54" y2="-10.16" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-2.54" y1="-10.16" x2="-1.905" y2="-9.525" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="1.905" y1="-6.985" x2="2.54" y2="-7.62" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="2.54" y1="-7.62" x2="1.905" y2="-8.255" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-1.905" y1="-5.715" x2="-2.54" y2="-5.08" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-2.54" y1="-5.08" x2="-1.905" y2="-4.445" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="1.905" y1="-1.905" x2="2.54" y2="-2.54" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="2.54" y1="-2.54" x2="1.905" y2="-3.175" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-1.905" y1="-0.635" x2="-2.54" y2="0" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-2.54" y1="0" x2="-1.905" y2="0.635" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="1.905" y1="3.175" x2="2.54" y2="2.54" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="2.54" y1="2.54" x2="1.905" y2="1.905" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-1.905" y1="4.445" x2="-2.54" y2="5.08" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-2.54" y1="5.08" x2="-1.905" y2="5.715" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="1.905" y1="8.255" x2="2.54" y2="7.62" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="2.54" y1="7.62" x2="1.905" y2="6.985" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-1.905" y1="9.525" x2="-2.54" y2="10.16" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-2.54" y1="10.16" x2="-1.905" y2="10.795" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="1.905" y1="13.335" x2="2.54" y2="12.7" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="2.54" y1="12.7" x2="1.905" y2="12.065" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-1.905" y1="14.605" x2="-2.54" y2="15.24" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-2.54" y1="15.24" x2="-1.905" y2="15.875" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="1.905" y1="18.415" x2="2.54" y2="17.78" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="2.54" y1="17.78" x2="1.905" y2="17.145" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-1.905" y1="19.685" x2="-2.54" y2="20.32" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-2.54" y1="20.32" x2="-1.905" y2="20.955" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="1.905" y1="23.495" x2="2.54" y2="22.86" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="2.54" y1="22.86" x2="1.905" y2="22.225" width="0.254" layer="94" curve="-90" cap="flat"/>
<wire x1="-5.08" y1="-25.4" x2="-2.54" y2="-25.4" width="0.1524" layer="94"/>
<wire x1="2.54" y1="-22.86" x2="5.08" y2="-22.86" width="0.1524" layer="94"/>
<wire x1="-5.08" y1="-20.32" x2="-2.54" y2="-20.32" width="0.1524" layer="94"/>
<wire x1="-5.08" y1="-15.24" x2="-2.54" y2="-15.24" width="0.1524" layer="94"/>
<wire x1="-5.08" y1="-10.16" x2="-2.54" y2="-10.16" width="0.1524" layer="94"/>
<wire x1="2.54" y1="-17.78" x2="5.08" y2="-17.78" width="0.1524" layer="94"/>
<wire x1="2.54" y1="-12.7" x2="5.08" y2="-12.7" width="0.1524" layer="94"/>
<wire x1="2.54" y1="-7.62" x2="5.08" y2="-7.62" width="0.1524" layer="94"/>
<wire x1="2.54" y1="-2.54" x2="5.08" y2="-2.54" width="0.1524" layer="94"/>
<wire x1="-5.08" y1="-5.08" x2="-2.54" y2="-5.08" width="0.1524" layer="94"/>
<wire x1="-5.08" y1="0" x2="-2.54" y2="0" width="0.1524" layer="94"/>
<wire x1="2.54" y1="2.54" x2="5.08" y2="2.54" width="0.1524" layer="94"/>
<wire x1="2.54" y1="7.62" x2="5.08" y2="7.62" width="0.1524" layer="94"/>
<wire x1="-5.08" y1="5.08" x2="-2.54" y2="5.08" width="0.1524" layer="94"/>
<wire x1="-5.08" y1="10.16" x2="-2.54" y2="10.16" width="0.1524" layer="94"/>
<wire x1="-5.08" y1="15.24" x2="-2.54" y2="15.24" width="0.1524" layer="94"/>
<wire x1="2.54" y1="12.7" x2="5.08" y2="12.7" width="0.1524" layer="94"/>
<wire x1="2.54" y1="17.78" x2="5.08" y2="17.78" width="0.1524" layer="94"/>
<wire x1="2.54" y1="22.86" x2="5.08" y2="22.86" width="0.1524" layer="94"/>
<wire x1="-5.08" y1="20.32" x2="-2.54" y2="20.32" width="0.1524" layer="94"/>
<circle x="-5.08" y="25.4" radius="0.381" width="0.4064" layer="94"/>
<text x="-5.08" y="-30.48" size="1.778" layer="96">&gt;VALUE</text>
<text x="-5.08" y="27.94" size="1.778" layer="95">&gt;NAME</text>
<pin name="1" x="-7.62" y="-25.4" visible="pad" length="short" direction="pas"/>
<pin name="2" x="7.62" y="-22.86" visible="pad" length="short" direction="pas" rot="R180"/>
<pin name="3" x="-7.62" y="-20.32" visible="pad" length="short" direction="pas"/>
<pin name="4" x="7.62" y="-17.78" visible="pad" length="short" direction="pas" rot="R180"/>
<pin name="5" x="-7.62" y="-15.24" visible="pad" length="short" direction="pas"/>
<pin name="6" x="7.62" y="-12.7" visible="pad" length="short" direction="pas" rot="R180"/>
<pin name="7" x="-7.62" y="-10.16" visible="pad" length="short" direction="pas"/>
<pin name="8" x="7.62" y="-7.62" visible="pad" length="short" direction="pas" rot="R180"/>
<pin name="9" x="-7.62" y="-5.08" visible="pad" length="short" direction="pas"/>
<pin name="10" x="7.62" y="-2.54" visible="pad" length="short" direction="pas" rot="R180"/>
<pin name="11" x="-7.62" y="0" visible="pad" length="short" direction="pas"/>
<pin name="12" x="7.62" y="2.54" visible="pad" length="short" direction="pas" rot="R180"/>
<pin name="13" x="-7.62" y="5.08" visible="pad" length="short" direction="pas"/>
<pin name="14" x="7.62" y="7.62" visible="pad" length="short" direction="pas" rot="R180"/>
<pin name="15" x="-7.62" y="10.16" visible="pad" length="short" direction="pas"/>
<pin name="16" x="7.62" y="12.7" visible="pad" length="short" direction="pas" rot="R180"/>
<pin name="17" x="-7.62" y="15.24" visible="pad" length="short" direction="pas"/>
<pin name="18" x="7.62" y="17.78" visible="pad" length="short" direction="pas" rot="R180"/>
<pin name="19" x="-7.62" y="20.32" visible="pad" length="short" direction="pas"/>
<pin name="20" x="7.62" y="22.86" visible="pad" length="short" direction="pas" rot="R180"/>
<pin name="21" x="-7.62" y="25.4" visible="pad" length="short" direction="pas"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="SCART-F" prefix="X">
<description>TV SCART &lt;B&gt;CONNECTOR&lt;/B&gt;</description>
<gates>
<gate name="G$1" symbol="SCART" x="0" y="0"/>
</gates>
<devices>
<device name="" package="SCART-F">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="10" pad="10"/>
<connect gate="G$1" pin="11" pad="11"/>
<connect gate="G$1" pin="12" pad="12"/>
<connect gate="G$1" pin="13" pad="13"/>
<connect gate="G$1" pin="14" pad="14"/>
<connect gate="G$1" pin="15" pad="15"/>
<connect gate="G$1" pin="16" pad="16"/>
<connect gate="G$1" pin="17" pad="17"/>
<connect gate="G$1" pin="18" pad="18"/>
<connect gate="G$1" pin="19" pad="19"/>
<connect gate="G$1" pin="2" pad="2"/>
<connect gate="G$1" pin="20" pad="20"/>
<connect gate="G$1" pin="21" pad="21"/>
<connect gate="G$1" pin="3" pad="3"/>
<connect gate="G$1" pin="4" pad="4"/>
<connect gate="G$1" pin="5" pad="5"/>
<connect gate="G$1" pin="6" pad="6"/>
<connect gate="G$1" pin="7" pad="7"/>
<connect gate="G$1" pin="8" pad="8"/>
<connect gate="G$1" pin="9" pad="9"/>
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
<library name="cpcfpga">
<packages>
<package name="ACTEL_HDR">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<wire x1="-24.765" y1="3.81" x2="-23.495" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-23.495" y1="3.81" x2="-22.86" y2="3.175" width="0.1524" layer="21"/>
<wire x1="-22.86" y1="3.175" x2="-22.225" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-22.225" y1="3.81" x2="-20.955" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-20.955" y1="3.81" x2="-20.32" y2="3.175" width="0.1524" layer="21"/>
<wire x1="-24.765" y1="3.81" x2="-25.4" y2="3.175" width="0.1524" layer="21"/>
<wire x1="-20.32" y1="3.175" x2="-19.685" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-19.685" y1="3.81" x2="-18.415" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-18.415" y1="3.81" x2="-17.78" y2="3.175" width="0.1524" layer="21"/>
<wire x1="-17.145" y1="3.81" x2="-15.875" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-15.875" y1="3.81" x2="-15.24" y2="3.175" width="0.1524" layer="21"/>
<wire x1="-15.24" y1="3.175" x2="-14.605" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-14.605" y1="3.81" x2="-13.335" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-13.335" y1="3.81" x2="-12.7" y2="3.175" width="0.1524" layer="21"/>
<wire x1="-17.145" y1="3.81" x2="-17.78" y2="3.175" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="3.175" x2="-12.065" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-12.065" y1="3.81" x2="-10.795" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-10.795" y1="3.81" x2="-10.16" y2="3.175" width="0.1524" layer="21"/>
<wire x1="-22.86" y1="-3.175" x2="-23.495" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-20.32" y1="-3.175" x2="-20.955" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-20.955" y1="-3.81" x2="-22.225" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-22.225" y1="-3.81" x2="-22.86" y2="-3.175" width="0.1524" layer="21"/>
<wire x1="-25.4" y1="3.175" x2="-25.4" y2="-3.175" width="0.1524" layer="21"/>
<wire x1="-25.4" y1="-3.175" x2="-24.765" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-23.495" y1="-3.81" x2="-24.765" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-17.78" y1="-3.175" x2="-18.415" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-18.415" y1="-3.81" x2="-19.685" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-19.685" y1="-3.81" x2="-20.32" y2="-3.175" width="0.1524" layer="21"/>
<wire x1="-15.24" y1="-3.175" x2="-15.875" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="-3.175" x2="-13.335" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-13.335" y1="-3.81" x2="-14.605" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-14.605" y1="-3.81" x2="-15.24" y2="-3.175" width="0.1524" layer="21"/>
<wire x1="-17.78" y1="-3.175" x2="-17.145" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-15.875" y1="-3.81" x2="-17.145" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="-3.175" x2="-10.795" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-10.795" y1="-3.81" x2="-12.065" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-12.065" y1="-3.81" x2="-12.7" y2="-3.175" width="0.1524" layer="21"/>
<wire x1="-8.255" y1="3.81" x2="-7.62" y2="3.175" width="0.1524" layer="21"/>
<wire x1="-9.525" y1="3.81" x2="-8.255" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="3.175" x2="-9.525" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-9.525" y1="-3.81" x2="-10.16" y2="-3.175" width="0.1524" layer="21"/>
<wire x1="-8.255" y1="-3.81" x2="-9.525" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="-3.175" x2="-8.255" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-6.985" y1="3.81" x2="-5.715" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-5.715" y1="3.81" x2="-5.08" y2="3.175" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="3.175" x2="-4.445" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-4.445" y1="3.81" x2="-3.175" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="3.81" x2="-2.54" y2="3.175" width="0.1524" layer="21"/>
<wire x1="-6.985" y1="3.81" x2="-7.62" y2="3.175" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="3.175" x2="-1.905" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="3.81" x2="-0.635" y2="3.81" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="3.81" x2="0" y2="3.175" width="0.1524" layer="21"/>
<wire x1="0.635" y1="3.81" x2="1.905" y2="3.81" width="0.1524" layer="21"/>
<wire x1="1.905" y1="3.81" x2="2.54" y2="3.175" width="0.1524" layer="21"/>
<wire x1="2.54" y1="3.175" x2="3.175" y2="3.81" width="0.1524" layer="21"/>
<wire x1="3.175" y1="3.81" x2="4.445" y2="3.81" width="0.1524" layer="21"/>
<wire x1="4.445" y1="3.81" x2="5.08" y2="3.175" width="0.1524" layer="21"/>
<wire x1="0.635" y1="3.81" x2="0" y2="3.175" width="0.1524" layer="21"/>
<wire x1="5.08" y1="3.175" x2="5.715" y2="3.81" width="0.1524" layer="21"/>
<wire x1="5.715" y1="3.81" x2="6.985" y2="3.81" width="0.1524" layer="21"/>
<wire x1="6.985" y1="3.81" x2="7.62" y2="3.175" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="-3.175" x2="-5.715" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="-3.175" x2="-3.175" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="-3.81" x2="-4.445" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-4.445" y1="-3.81" x2="-5.08" y2="-3.175" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="-3.175" x2="-6.985" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-5.715" y1="-3.81" x2="-6.985" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="0" y1="-3.175" x2="-0.635" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="-3.81" x2="-1.905" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="-3.81" x2="-2.54" y2="-3.175" width="0.1524" layer="21"/>
<wire x1="2.54" y1="-3.175" x2="1.905" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="5.08" y1="-3.175" x2="4.445" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="4.445" y1="-3.81" x2="3.175" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="3.175" y1="-3.81" x2="2.54" y2="-3.175" width="0.1524" layer="21"/>
<wire x1="0" y1="-3.175" x2="0.635" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="1.905" y1="-3.81" x2="0.635" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="7.62" y1="-3.175" x2="6.985" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="6.985" y1="-3.81" x2="5.715" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="5.715" y1="-3.81" x2="5.08" y2="-3.175" width="0.1524" layer="21"/>
<wire x1="9.525" y1="3.81" x2="10.16" y2="3.175" width="0.1524" layer="21"/>
<wire x1="8.255" y1="3.81" x2="9.525" y2="3.81" width="0.1524" layer="21"/>
<wire x1="7.62" y1="3.175" x2="8.255" y2="3.81" width="0.1524" layer="21"/>
<wire x1="8.255" y1="-3.81" x2="7.62" y2="-3.175" width="0.1524" layer="21"/>
<wire x1="9.525" y1="-3.81" x2="8.255" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="10.16" y1="-3.175" x2="9.525" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="10.795" y1="3.81" x2="12.065" y2="3.81" width="0.1524" layer="21"/>
<wire x1="12.065" y1="3.81" x2="12.7" y2="3.175" width="0.1524" layer="21"/>
<wire x1="12.7" y1="3.175" x2="13.335" y2="3.81" width="0.1524" layer="21"/>
<wire x1="13.335" y1="3.81" x2="14.605" y2="3.81" width="0.1524" layer="21"/>
<wire x1="14.605" y1="3.81" x2="15.24" y2="3.175" width="0.1524" layer="21"/>
<wire x1="10.795" y1="3.81" x2="10.16" y2="3.175" width="0.1524" layer="21"/>
<wire x1="15.24" y1="3.175" x2="15.875" y2="3.81" width="0.1524" layer="21"/>
<wire x1="15.875" y1="3.81" x2="17.145" y2="3.81" width="0.1524" layer="21"/>
<wire x1="17.145" y1="3.81" x2="17.78" y2="3.175" width="0.1524" layer="21"/>
<wire x1="18.415" y1="3.81" x2="19.685" y2="3.81" width="0.1524" layer="21"/>
<wire x1="19.685" y1="3.81" x2="20.32" y2="3.175" width="0.1524" layer="21"/>
<wire x1="20.32" y1="3.175" x2="20.955" y2="3.81" width="0.1524" layer="21"/>
<wire x1="20.955" y1="3.81" x2="22.225" y2="3.81" width="0.1524" layer="21"/>
<wire x1="22.225" y1="3.81" x2="22.86" y2="3.175" width="0.1524" layer="21"/>
<wire x1="18.415" y1="3.81" x2="17.78" y2="3.175" width="0.1524" layer="21"/>
<wire x1="22.86" y1="3.175" x2="23.495" y2="3.81" width="0.1524" layer="21"/>
<wire x1="23.495" y1="3.81" x2="24.765" y2="3.81" width="0.1524" layer="21"/>
<wire x1="12.7" y1="-3.175" x2="12.065" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="15.24" y1="-3.175" x2="14.605" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="14.605" y1="-3.81" x2="13.335" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="13.335" y1="-3.81" x2="12.7" y2="-3.175" width="0.1524" layer="21"/>
<wire x1="10.16" y1="-3.175" x2="10.795" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="12.065" y1="-3.81" x2="10.795" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="17.78" y1="-3.175" x2="17.145" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="17.145" y1="-3.81" x2="15.875" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="15.875" y1="-3.81" x2="15.24" y2="-3.175" width="0.1524" layer="21"/>
<wire x1="20.32" y1="-3.175" x2="19.685" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="22.86" y1="-3.175" x2="22.225" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="22.225" y1="-3.81" x2="20.955" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="20.955" y1="-3.81" x2="20.32" y2="-3.175" width="0.1524" layer="21"/>
<wire x1="17.78" y1="-3.175" x2="18.415" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="19.685" y1="-3.81" x2="18.415" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="24.765" y1="-3.81" x2="23.495" y2="-3.81" width="0.1524" layer="21"/>
<wire x1="23.495" y1="-3.81" x2="22.86" y2="-3.175" width="0.1524" layer="21"/>
<wire x1="25.4" y1="3.175" x2="25.4" y2="-3.175" width="0.1524" layer="21"/>
<wire x1="24.765" y1="3.81" x2="25.4" y2="3.175" width="0.1524" layer="21"/>
<wire x1="25.4" y1="-3.175" x2="24.765" y2="-3.81" width="0.1524" layer="21"/>
<pad name="1" x="-24.13" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="3" x="-21.59" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="5" x="-19.05" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="7" x="-16.51" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="9" x="-13.97" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="11" x="-11.43" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="2" x="-24.13" y="2.54" drill="1.016" shape="octagon"/>
<pad name="4" x="-21.59" y="2.54" drill="1.016" shape="octagon"/>
<pad name="6" x="-19.05" y="2.54" drill="1.016" shape="octagon"/>
<pad name="8" x="-16.51" y="2.54" drill="1.016" shape="octagon"/>
<pad name="10" x="-13.97" y="2.54" drill="1.016" shape="octagon"/>
<pad name="12" x="-11.43" y="2.54" drill="1.016" shape="octagon"/>
<pad name="13" x="-8.89" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="14" x="-8.89" y="2.54" drill="1.016" shape="octagon"/>
<pad name="15" x="-6.35" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="17" x="-3.81" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="19" x="-1.27" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="21" x="1.27" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="23" x="3.81" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="25" x="6.35" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="16" x="-6.35" y="2.54" drill="1.016" shape="octagon"/>
<pad name="18" x="-3.81" y="2.54" drill="1.016" shape="octagon"/>
<pad name="20" x="-1.27" y="2.54" drill="1.016" shape="octagon"/>
<pad name="22" x="1.27" y="2.54" drill="1.016" shape="octagon"/>
<pad name="24" x="3.81" y="2.54" drill="1.016" shape="octagon"/>
<pad name="26" x="6.35" y="2.54" drill="1.016" shape="octagon"/>
<pad name="27" x="8.89" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="28" x="8.89" y="2.54" drill="1.016" shape="octagon"/>
<pad name="29" x="11.43" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="31" x="13.97" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="33" x="16.51" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="35" x="19.05" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="37" x="21.59" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="39" x="24.13" y="-2.54" drill="1.016" shape="octagon"/>
<pad name="30" x="11.43" y="2.54" drill="1.016" shape="octagon"/>
<pad name="32" x="13.97" y="2.54" drill="1.016" shape="octagon"/>
<pad name="34" x="16.51" y="2.54" drill="1.016" shape="octagon"/>
<pad name="36" x="19.05" y="2.54" drill="1.016" shape="octagon"/>
<pad name="38" x="21.59" y="2.54" drill="1.016" shape="octagon"/>
<pad name="40" x="24.13" y="2.54" drill="1.016" shape="octagon"/>
<text x="-24.638" y="-5.461" size="1.27" layer="21" ratio="10">1</text>
<text x="-25.4" y="4.191" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="12.7" y="-5.461" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
<text x="22.86" y="4.191" size="1.27" layer="21" ratio="10">40</text>
<rectangle x1="-21.844" y1="-2.794" x2="-21.336" y2="-2.286" layer="51"/>
<rectangle x1="-24.384" y1="-2.794" x2="-23.876" y2="-2.286" layer="51"/>
<rectangle x1="-19.304" y1="-2.794" x2="-18.796" y2="-2.286" layer="51"/>
<rectangle x1="-14.224" y1="-2.794" x2="-13.716" y2="-2.286" layer="51"/>
<rectangle x1="-16.764" y1="-2.794" x2="-16.256" y2="-2.286" layer="51"/>
<rectangle x1="-11.684" y1="-2.794" x2="-11.176" y2="-2.286" layer="51"/>
<rectangle x1="-24.384" y1="-0.254" x2="-23.876" y2="0.254" layer="51"/>
<rectangle x1="-24.384" y1="2.286" x2="-23.876" y2="2.794" layer="51"/>
<rectangle x1="-21.844" y1="-0.254" x2="-21.336" y2="0.254" layer="51"/>
<rectangle x1="-21.844" y1="2.286" x2="-21.336" y2="2.794" layer="51"/>
<rectangle x1="-19.304" y1="-0.254" x2="-18.796" y2="0.254" layer="51"/>
<rectangle x1="-19.304" y1="2.286" x2="-18.796" y2="2.794" layer="51"/>
<rectangle x1="-16.764" y1="-0.254" x2="-16.256" y2="0.254" layer="51"/>
<rectangle x1="-16.764" y1="2.286" x2="-16.256" y2="2.794" layer="51"/>
<rectangle x1="-14.224" y1="-0.254" x2="-13.716" y2="0.254" layer="51"/>
<rectangle x1="-14.224" y1="2.286" x2="-13.716" y2="2.794" layer="51"/>
<rectangle x1="-11.684" y1="-0.254" x2="-11.176" y2="0.254" layer="51"/>
<rectangle x1="-11.684" y1="2.286" x2="-11.176" y2="2.794" layer="51"/>
<rectangle x1="-9.144" y1="-0.254" x2="-8.636" y2="0.254" layer="51"/>
<rectangle x1="-9.144" y1="2.286" x2="-8.636" y2="2.794" layer="51"/>
<rectangle x1="-9.144" y1="-2.794" x2="-8.636" y2="-2.286" layer="51"/>
<rectangle x1="-4.064" y1="-2.794" x2="-3.556" y2="-2.286" layer="51"/>
<rectangle x1="-6.604" y1="-2.794" x2="-6.096" y2="-2.286" layer="51"/>
<rectangle x1="-1.524" y1="-2.794" x2="-1.016" y2="-2.286" layer="51"/>
<rectangle x1="3.556" y1="-2.794" x2="4.064" y2="-2.286" layer="51"/>
<rectangle x1="1.016" y1="-2.794" x2="1.524" y2="-2.286" layer="51"/>
<rectangle x1="6.096" y1="-2.794" x2="6.604" y2="-2.286" layer="51"/>
<rectangle x1="-6.604" y1="-0.254" x2="-6.096" y2="0.254" layer="51"/>
<rectangle x1="-6.604" y1="2.286" x2="-6.096" y2="2.794" layer="51"/>
<rectangle x1="-4.064" y1="-0.254" x2="-3.556" y2="0.254" layer="51"/>
<rectangle x1="-4.064" y1="2.286" x2="-3.556" y2="2.794" layer="51"/>
<rectangle x1="-1.524" y1="-0.254" x2="-1.016" y2="0.254" layer="51"/>
<rectangle x1="-1.524" y1="2.286" x2="-1.016" y2="2.794" layer="51"/>
<rectangle x1="1.016" y1="-0.254" x2="1.524" y2="0.254" layer="51"/>
<rectangle x1="1.016" y1="2.286" x2="1.524" y2="2.794" layer="51"/>
<rectangle x1="3.556" y1="-0.254" x2="4.064" y2="0.254" layer="51"/>
<rectangle x1="3.556" y1="2.286" x2="4.064" y2="2.794" layer="51"/>
<rectangle x1="6.096" y1="-0.254" x2="6.604" y2="0.254" layer="51"/>
<rectangle x1="6.096" y1="2.286" x2="6.604" y2="2.794" layer="51"/>
<rectangle x1="8.636" y1="-0.254" x2="9.144" y2="0.254" layer="51"/>
<rectangle x1="8.636" y1="2.286" x2="9.144" y2="2.794" layer="51"/>
<rectangle x1="8.636" y1="-2.794" x2="9.144" y2="-2.286" layer="51"/>
<rectangle x1="13.716" y1="-2.794" x2="14.224" y2="-2.286" layer="51"/>
<rectangle x1="11.176" y1="-2.794" x2="11.684" y2="-2.286" layer="51"/>
<rectangle x1="16.256" y1="-2.794" x2="16.764" y2="-2.286" layer="51"/>
<rectangle x1="21.336" y1="-2.794" x2="21.844" y2="-2.286" layer="51"/>
<rectangle x1="18.796" y1="-2.794" x2="19.304" y2="-2.286" layer="51"/>
<rectangle x1="23.876" y1="-2.794" x2="24.384" y2="-2.286" layer="51"/>
<rectangle x1="11.176" y1="-0.254" x2="11.684" y2="0.254" layer="51"/>
<rectangle x1="11.176" y1="2.286" x2="11.684" y2="2.794" layer="51"/>
<rectangle x1="13.716" y1="-0.254" x2="14.224" y2="0.254" layer="51"/>
<rectangle x1="13.716" y1="2.286" x2="14.224" y2="2.794" layer="51"/>
<rectangle x1="16.256" y1="-0.254" x2="16.764" y2="0.254" layer="51"/>
<rectangle x1="16.256" y1="2.286" x2="16.764" y2="2.794" layer="51"/>
<rectangle x1="18.796" y1="-0.254" x2="19.304" y2="0.254" layer="51"/>
<rectangle x1="18.796" y1="2.286" x2="19.304" y2="2.794" layer="51"/>
<rectangle x1="21.336" y1="-0.254" x2="21.844" y2="0.254" layer="51"/>
<rectangle x1="21.336" y1="2.286" x2="21.844" y2="2.794" layer="51"/>
<rectangle x1="23.876" y1="-0.254" x2="24.384" y2="0.254" layer="51"/>
<rectangle x1="23.876" y1="2.286" x2="24.384" y2="2.794" layer="51"/>
<pad name="41" x="-24.13" y="0" drill="1.016" shape="octagon"/>
<pad name="42" x="-21.59" y="0" drill="1.016" shape="octagon"/>
<wire x1="-21.59" y1="0" x2="-24.13" y2="0" width="0.1524" layer="16"/>
<pad name="43" x="-19.05" y="0" drill="1.016" shape="octagon"/>
<wire x1="-19.05" y1="0" x2="-21.59" y2="0" width="0.1524" layer="16"/>
<pad name="44" x="-16.51" y="0" drill="1.016" shape="octagon"/>
<wire x1="-16.51" y1="0" x2="-19.05" y2="0" width="0.1524" layer="16"/>
<pad name="45" x="-13.97" y="0" drill="1.016" shape="octagon"/>
<wire x1="-13.97" y1="0" x2="-16.51" y2="0" width="0.1524" layer="16"/>
<pad name="46" x="-11.43" y="0" drill="1.016" shape="octagon"/>
<wire x1="-11.43" y1="0" x2="-13.97" y2="0" width="0.1524" layer="16"/>
<pad name="47" x="-8.89" y="0" drill="1.016" shape="octagon"/>
<wire x1="-8.89" y1="0" x2="-11.43" y2="0" width="0.1524" layer="16"/>
<pad name="48" x="-6.35" y="0" drill="1.016" shape="octagon"/>
<wire x1="-6.35" y1="0" x2="-8.89" y2="0" width="0.1524" layer="16"/>
<pad name="49" x="-3.81" y="0" drill="1.016" shape="octagon"/>
<wire x1="-3.81" y1="0" x2="-6.35" y2="0" width="0.1524" layer="16"/>
<pad name="50" x="-1.27" y="0" drill="1.016" shape="octagon"/>
<wire x1="-1.27" y1="0" x2="-3.81" y2="0" width="0.1524" layer="16"/>
<pad name="51" x="1.27" y="0" drill="1.016" shape="octagon"/>
<wire x1="1.27" y1="0" x2="-1.27" y2="0" width="0.1524" layer="16"/>
<pad name="52" x="3.81" y="0" drill="1.016" shape="octagon"/>
<wire x1="3.81" y1="0" x2="1.27" y2="0" width="0.1524" layer="16"/>
<pad name="53" x="6.35" y="0" drill="1.016" shape="octagon"/>
<wire x1="6.35" y1="0" x2="3.81" y2="0" width="0.1524" layer="16"/>
<pad name="54" x="8.89" y="0" drill="1.016" shape="octagon"/>
<wire x1="8.89" y1="0" x2="6.35" y2="0" width="0.1524" layer="16"/>
<pad name="55" x="11.43" y="0" drill="1.016" shape="octagon"/>
<wire x1="11.43" y1="0" x2="8.89" y2="0" width="0.1524" layer="16"/>
<pad name="56" x="13.97" y="0" drill="1.016" shape="octagon"/>
<wire x1="13.97" y1="0" x2="11.43" y2="0" width="0.1524" layer="16"/>
<pad name="57" x="16.51" y="0" drill="1.016" shape="octagon"/>
<wire x1="16.51" y1="0" x2="13.97" y2="0" width="0.1524" layer="16"/>
<pad name="58" x="19.05" y="0" drill="1.016" shape="octagon"/>
<wire x1="19.05" y1="0" x2="16.51" y2="0" width="0.1524" layer="16"/>
<pad name="59" x="21.59" y="0" drill="1.016" shape="octagon"/>
<wire x1="21.59" y1="0" x2="19.05" y2="0" width="0.1524" layer="16"/>
<pad name="60" x="24.13" y="0" drill="1.016" shape="octagon"/>
<wire x1="24.13" y1="0" x2="21.59" y2="0" width="0.1524" layer="16"/>
</package>
</packages>
<symbols>
<symbol name="ACTEL_HDR">
<wire x1="3.81" y1="-29.21" x2="-3.81" y2="-29.21" width="0.4064" layer="94"/>
<wire x1="1.27" y1="-20.32" x2="2.54" y2="-20.32" width="0.6096" layer="94"/>
<wire x1="1.27" y1="-22.86" x2="2.54" y2="-22.86" width="0.6096" layer="94"/>
<wire x1="1.27" y1="-25.4" x2="2.54" y2="-25.4" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="-20.32" x2="-1.27" y2="-20.32" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="-22.86" x2="-1.27" y2="-22.86" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="-25.4" x2="-1.27" y2="-25.4" width="0.6096" layer="94"/>
<wire x1="1.27" y1="-15.24" x2="2.54" y2="-15.24" width="0.6096" layer="94"/>
<wire x1="1.27" y1="-17.78" x2="2.54" y2="-17.78" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="-15.24" x2="-1.27" y2="-15.24" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="-17.78" x2="-1.27" y2="-17.78" width="0.6096" layer="94"/>
<wire x1="1.27" y1="-7.62" x2="2.54" y2="-7.62" width="0.6096" layer="94"/>
<wire x1="1.27" y1="-10.16" x2="2.54" y2="-10.16" width="0.6096" layer="94"/>
<wire x1="1.27" y1="-12.7" x2="2.54" y2="-12.7" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="-7.62" x2="-1.27" y2="-7.62" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="-10.16" x2="-1.27" y2="-10.16" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="-12.7" x2="-1.27" y2="-12.7" width="0.6096" layer="94"/>
<wire x1="1.27" y1="-2.54" x2="2.54" y2="-2.54" width="0.6096" layer="94"/>
<wire x1="1.27" y1="-5.08" x2="2.54" y2="-5.08" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="-2.54" x2="-1.27" y2="-2.54" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="-5.08" x2="-1.27" y2="-5.08" width="0.6096" layer="94"/>
<wire x1="1.27" y1="5.08" x2="2.54" y2="5.08" width="0.6096" layer="94"/>
<wire x1="1.27" y1="2.54" x2="2.54" y2="2.54" width="0.6096" layer="94"/>
<wire x1="1.27" y1="0" x2="2.54" y2="0" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="5.08" x2="-1.27" y2="5.08" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="2.54" x2="-1.27" y2="2.54" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="0" x2="-1.27" y2="0" width="0.6096" layer="94"/>
<wire x1="1.27" y1="10.16" x2="2.54" y2="10.16" width="0.6096" layer="94"/>
<wire x1="1.27" y1="7.62" x2="2.54" y2="7.62" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="10.16" x2="-1.27" y2="10.16" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="7.62" x2="-1.27" y2="7.62" width="0.6096" layer="94"/>
<wire x1="1.27" y1="15.24" x2="2.54" y2="15.24" width="0.6096" layer="94"/>
<wire x1="1.27" y1="12.7" x2="2.54" y2="12.7" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="15.24" x2="-1.27" y2="15.24" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="12.7" x2="-1.27" y2="12.7" width="0.6096" layer="94"/>
<wire x1="-3.81" y1="26.67" x2="-3.81" y2="-29.21" width="0.4064" layer="94"/>
<wire x1="3.81" y1="-29.21" x2="3.81" y2="26.67" width="0.4064" layer="94"/>
<wire x1="-3.81" y1="26.67" x2="3.81" y2="26.67" width="0.4064" layer="94"/>
<wire x1="-2.54" y1="17.78" x2="-1.27" y2="17.78" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="20.32" x2="-1.27" y2="20.32" width="0.6096" layer="94"/>
<wire x1="-2.54" y1="22.86" x2="-1.27" y2="22.86" width="0.6096" layer="94"/>
<wire x1="1.27" y1="17.78" x2="2.54" y2="17.78" width="0.6096" layer="94"/>
<wire x1="1.27" y1="20.32" x2="2.54" y2="20.32" width="0.6096" layer="94"/>
<wire x1="1.27" y1="22.86" x2="2.54" y2="22.86" width="0.6096" layer="94"/>
<text x="-3.81" y="-31.75" size="1.778" layer="96">&gt;VALUE</text>
<text x="-3.81" y="27.432" size="1.778" layer="95">&gt;NAME</text>
<pin name="1" x="7.62" y="-25.4" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="3" x="7.62" y="-22.86" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="5" x="7.62" y="-20.32" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="2" x="-7.62" y="-25.4" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="4" x="-7.62" y="-22.86" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="6" x="-7.62" y="-20.32" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="7" x="7.62" y="-17.78" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="9" x="7.62" y="-15.24" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="8" x="-7.62" y="-17.78" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="10" x="-7.62" y="-15.24" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="11" x="7.62" y="-12.7" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="13" x="7.62" y="-10.16" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="15" x="7.62" y="-7.62" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="12" x="-7.62" y="-12.7" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="14" x="-7.62" y="-10.16" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="16" x="-7.62" y="-7.62" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="17" x="7.62" y="-5.08" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="19" x="7.62" y="-2.54" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="18" x="-7.62" y="-5.08" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="20" x="-7.62" y="-2.54" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="21" x="7.62" y="0" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="23" x="7.62" y="2.54" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="25" x="7.62" y="5.08" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="22" x="-7.62" y="0" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="24" x="-7.62" y="2.54" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="26" x="-7.62" y="5.08" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="27" x="7.62" y="7.62" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="29" x="7.62" y="10.16" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="28" x="-7.62" y="7.62" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="30" x="-7.62" y="10.16" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="31" x="7.62" y="12.7" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="33" x="7.62" y="15.24" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="32" x="-7.62" y="12.7" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="34" x="-7.62" y="15.24" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="36" x="-7.62" y="17.78" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="38" x="-7.62" y="20.32" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="40" x="-7.62" y="22.86" visible="pad" length="middle" direction="pas" swaplevel="1"/>
<pin name="35" x="7.62" y="17.78" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="37" x="7.62" y="20.32" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<pin name="39" x="7.62" y="22.86" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
<wire x1="1.27" y1="-27.94" x2="2.54" y2="-27.94" width="0.6096" layer="94"/>
<pin name="41" x="7.62" y="-27.94" visible="pad" length="middle" direction="pas" swaplevel="1" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="ACTEL_HDR" prefix="SV" uservalue="yes">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<gates>
<gate name="G$1" symbol="ACTEL_HDR" x="0" y="0"/>
</gates>
<devices>
<device name="" package="ACTEL_HDR">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="10" pad="10"/>
<connect gate="G$1" pin="11" pad="11"/>
<connect gate="G$1" pin="12" pad="12"/>
<connect gate="G$1" pin="13" pad="13"/>
<connect gate="G$1" pin="14" pad="14"/>
<connect gate="G$1" pin="15" pad="15"/>
<connect gate="G$1" pin="16" pad="16"/>
<connect gate="G$1" pin="17" pad="17"/>
<connect gate="G$1" pin="18" pad="18"/>
<connect gate="G$1" pin="19" pad="19"/>
<connect gate="G$1" pin="2" pad="2"/>
<connect gate="G$1" pin="20" pad="20"/>
<connect gate="G$1" pin="21" pad="21"/>
<connect gate="G$1" pin="22" pad="22"/>
<connect gate="G$1" pin="23" pad="23"/>
<connect gate="G$1" pin="24" pad="24"/>
<connect gate="G$1" pin="25" pad="25"/>
<connect gate="G$1" pin="26" pad="26"/>
<connect gate="G$1" pin="27" pad="27"/>
<connect gate="G$1" pin="28" pad="28"/>
<connect gate="G$1" pin="29" pad="29"/>
<connect gate="G$1" pin="3" pad="3"/>
<connect gate="G$1" pin="30" pad="30"/>
<connect gate="G$1" pin="31" pad="31"/>
<connect gate="G$1" pin="32" pad="32"/>
<connect gate="G$1" pin="33" pad="33"/>
<connect gate="G$1" pin="34" pad="34"/>
<connect gate="G$1" pin="35" pad="35"/>
<connect gate="G$1" pin="36" pad="36"/>
<connect gate="G$1" pin="37" pad="37"/>
<connect gate="G$1" pin="38" pad="38"/>
<connect gate="G$1" pin="39" pad="39"/>
<connect gate="G$1" pin="4" pad="4"/>
<connect gate="G$1" pin="40" pad="40"/>
<connect gate="G$1" pin="41" pad="41"/>
<connect gate="G$1" pin="5" pad="5"/>
<connect gate="G$1" pin="6" pad="6"/>
<connect gate="G$1" pin="7" pad="7"/>
<connect gate="G$1" pin="8" pad="8"/>
<connect gate="G$1" pin="9" pad="9"/>
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
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="X1" library="con-hirschmann" deviceset="SCART-F" device=""/>
<part name="SV8" library="cpcfpga" deviceset="ACTEL_HDR" device=""/>
<part name="SV9" library="cpcfpga" deviceset="ACTEL_HDR" device=""/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="X1" gate="G$1" x="38.1" y="43.18"/>
<instance part="SV8" gate="G$1" x="226.06" y="63.5" rot="R270"/>
<instance part="SV9" gate="G$1" x="127" y="60.96" rot="R270"/>
</instances>
<busses>
</busses>
<nets>
<net name="ARIGHT" class="0">
<segment>
<pinref part="X1" gate="G$1" pin="2"/>
<wire x1="45.72" y1="20.32" x2="53.34" y2="20.32" width="0.1524" layer="91"/>
<label x="55.88" y="20.32" size="1.778" layer="95"/>
</segment>
</net>
<net name="AGND" class="0">
<segment>
<pinref part="X1" gate="G$1" pin="4"/>
<wire x1="45.72" y1="25.4" x2="53.34" y2="25.4" width="0.1524" layer="91"/>
<label x="55.88" y="25.4" size="1.778" layer="95"/>
</segment>
</net>
<net name="ALEFT" class="0">
<segment>
<pinref part="X1" gate="G$1" pin="6"/>
<wire x1="45.72" y1="30.48" x2="53.34" y2="30.48" width="0.1524" layer="91"/>
<label x="55.88" y="30.48" size="1.778" layer="95"/>
</segment>
</net>
<net name="D_FASTBLANKING" class="0">
<segment>
<pinref part="X1" gate="G$1" pin="16"/>
<wire x1="45.72" y1="55.88" x2="53.34" y2="55.88" width="0.1524" layer="91"/>
<label x="55.88" y="55.88" size="1.778" layer="95"/>
</segment>
</net>
<net name="D_GND" class="0">
<segment>
<pinref part="X1" gate="G$1" pin="18"/>
<wire x1="45.72" y1="60.96" x2="53.34" y2="60.96" width="0.1524" layer="91"/>
<label x="55.88" y="60.96" size="1.778" layer="95"/>
</segment>
</net>
<net name="COMP" class="0">
<segment>
<pinref part="X1" gate="G$1" pin="20"/>
<wire x1="45.72" y1="66.04" x2="53.34" y2="66.04" width="0.1524" layer="91"/>
<label x="55.88" y="66.04" size="1.778" layer="95"/>
</segment>
</net>
<net name="BLUE" class="0">
<segment>
<pinref part="X1" gate="G$1" pin="7"/>
<wire x1="30.48" y1="33.02" x2="22.86" y2="33.02" width="0.1524" layer="91"/>
<label x="15.24" y="33.02" size="1.778" layer="95"/>
</segment>
</net>
<net name="GREEN" class="0">
<segment>
<pinref part="X1" gate="G$1" pin="11"/>
<wire x1="30.48" y1="43.18" x2="22.86" y2="43.18" width="0.1524" layer="91"/>
<label x="15.24" y="43.18" size="1.778" layer="95"/>
</segment>
</net>
<net name="RED" class="0">
<segment>
<pinref part="X1" gate="G$1" pin="15"/>
<wire x1="30.48" y1="53.34" x2="22.86" y2="53.34" width="0.1524" layer="91"/>
<label x="15.24" y="53.34" size="1.778" layer="95"/>
</segment>
</net>
<net name="COMPGND" class="0">
<segment>
<pinref part="X1" gate="G$1" pin="17"/>
<wire x1="30.48" y1="58.42" x2="22.86" y2="58.42" width="0.1524" layer="91"/>
<label x="15.24" y="58.42" size="1.778" layer="95"/>
</segment>
</net>
<net name="VGND" class="0">
<segment>
<pinref part="X1" gate="G$1" pin="13"/>
<wire x1="30.48" y1="48.26" x2="22.86" y2="48.26" width="0.1524" layer="91"/>
<label x="15.24" y="48.26" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="X1" gate="G$1" pin="9"/>
<wire x1="30.48" y1="38.1" x2="22.86" y2="38.1" width="0.1524" layer="91"/>
<label x="15.24" y="38.1" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="X1" gate="G$1" pin="5"/>
<wire x1="30.48" y1="27.94" x2="22.86" y2="27.94" width="0.1524" layer="91"/>
<label x="15.24" y="27.94" size="1.778" layer="95"/>
</segment>
</net>
<net name="D_MODESWITCH" class="0">
<segment>
<pinref part="X1" gate="G$1" pin="8"/>
<wire x1="45.72" y1="35.56" x2="53.34" y2="35.56" width="0.1524" layer="91"/>
<label x="55.88" y="35.56" size="1.778" layer="95"/>
</segment>
</net>
<net name="GND" class="0">
<segment>
<label x="149.86" y="48.26" size="1.778" layer="95" rot="R270"/>
<pinref part="SV9" gate="G$1" pin="39"/>
<wire x1="149.86" y1="48.26" x2="149.86" y2="53.34" width="0.1524" layer="91"/>
<pinref part="SV9" gate="G$1" pin="37"/>
<wire x1="149.86" y1="53.34" x2="147.32" y2="53.34" width="0.1524" layer="91"/>
<junction x="149.86" y="53.34"/>
<pinref part="SV9" gate="G$1" pin="33"/>
<pinref part="SV9" gate="G$1" pin="35"/>
<wire x1="142.24" y1="53.34" x2="144.78" y2="53.34" width="0.1524" layer="91"/>
<wire x1="144.78" y1="53.34" x2="147.32" y2="53.34" width="0.1524" layer="91"/>
<junction x="144.78" y="53.34"/>
<junction x="147.32" y="53.34"/>
</segment>
<segment>
<pinref part="SV8" gate="G$1" pin="41"/>
<wire x1="198.12" y1="55.88" x2="190.5" y2="55.88" width="0.1524" layer="91"/>
<label x="187.96" y="55.88" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="SV9" gate="G$1" pin="41"/>
<wire x1="99.06" y1="53.34" x2="91.44" y2="53.34" width="0.1524" layer="91"/>
<label x="91.44" y="53.34" size="1.778" layer="95"/>
</segment>
</net>
<net name="VCC_B3" class="0">
<segment>
<label x="101.6" y="48.26" size="1.778" layer="95" rot="R270"/>
<pinref part="SV9" gate="G$1" pin="1"/>
<wire x1="101.6" y1="48.26" x2="101.6" y2="53.34" width="0.1524" layer="91"/>
<pinref part="SV9" gate="G$1" pin="3"/>
<wire x1="101.6" y1="53.34" x2="104.14" y2="53.34" width="0.1524" layer="91"/>
<junction x="101.6" y="53.34"/>
</segment>
</net>
<net name="R1" class="0">
<segment>
<label x="109.22" y="48.26" size="1.778" layer="95" rot="R270"/>
<pinref part="SV9" gate="G$1" pin="7"/>
<wire x1="109.22" y1="53.34" x2="109.22" y2="48.26" width="0.1524" layer="91"/>
</segment>
</net>
<net name="R0" class="0">
<segment>
<label x="111.76" y="48.26" size="1.778" layer="95" rot="R270"/>
<pinref part="SV9" gate="G$1" pin="9"/>
<wire x1="111.76" y1="48.26" x2="111.76" y2="53.34" width="0.1524" layer="91"/>
</segment>
</net>
<net name="G1" class="0">
<segment>
<label x="114.3" y="48.26" size="1.778" layer="95" rot="R270"/>
<pinref part="SV9" gate="G$1" pin="11"/>
<wire x1="114.3" y1="53.34" x2="114.3" y2="48.26" width="0.1524" layer="91"/>
</segment>
</net>
<net name="SRAM_A16" class="0">
<segment>
<wire x1="215.9" y1="55.88" x2="215.9" y2="33.02" width="0.1524" layer="91"/>
<label x="215.9" y="35.56" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="13"/>
</segment>
</net>
<net name="SRAM_A14" class="0">
<segment>
<wire x1="218.44" y1="55.88" x2="218.44" y2="35.56" width="0.1524" layer="91"/>
<label x="218.44" y="35.56" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="15"/>
</segment>
</net>
<net name="SRAM_A12" class="0">
<segment>
<wire x1="220.98" y1="55.88" x2="220.98" y2="35.56" width="0.1524" layer="91"/>
<label x="220.98" y="35.56" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="17"/>
</segment>
</net>
<net name="SRAM_A7" class="0">
<segment>
<wire x1="223.52" y1="55.88" x2="223.52" y2="35.56" width="0.1524" layer="91"/>
<label x="223.52" y="35.56" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="19"/>
</segment>
</net>
<net name="SRAM_A6" class="0">
<segment>
<wire x1="226.06" y1="55.88" x2="226.06" y2="35.56" width="0.1524" layer="91"/>
<label x="226.06" y="35.56" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="21"/>
</segment>
</net>
<net name="SRAM_A5" class="0">
<segment>
<wire x1="228.6" y1="55.88" x2="228.6" y2="35.56" width="0.1524" layer="91"/>
<label x="228.6" y="35.56" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="23"/>
</segment>
</net>
<net name="SRAM_A4" class="0">
<segment>
<wire x1="231.14" y1="55.88" x2="231.14" y2="35.56" width="0.1524" layer="91"/>
<label x="231.14" y="35.56" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="25"/>
</segment>
</net>
<net name="SRAM_A3" class="0">
<segment>
<wire x1="233.68" y1="55.88" x2="233.68" y2="35.56" width="0.1524" layer="91"/>
<label x="233.68" y="35.56" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="27"/>
</segment>
</net>
<net name="SRAM_A2" class="0">
<segment>
<wire x1="236.22" y1="55.88" x2="236.22" y2="35.56" width="0.1524" layer="91"/>
<label x="236.22" y="35.56" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="29"/>
</segment>
</net>
<net name="SRAM_A1" class="0">
<segment>
<wire x1="238.76" y1="55.88" x2="238.76" y2="35.56" width="0.1524" layer="91"/>
<label x="238.76" y="35.56" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="31"/>
</segment>
</net>
<net name="SRAM_A0" class="0">
<segment>
<wire x1="241.3" y1="55.88" x2="241.3" y2="35.56" width="0.1524" layer="91"/>
<label x="241.3" y="35.56" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="33"/>
</segment>
</net>
<net name="SRAM_DQ0" class="0">
<segment>
<wire x1="243.84" y1="55.88" x2="243.84" y2="35.56" width="0.1524" layer="91"/>
<label x="243.84" y="35.56" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="35"/>
</segment>
</net>
<net name="SRAM_DQ1" class="0">
<segment>
<wire x1="246.38" y1="55.88" x2="246.38" y2="35.56" width="0.1524" layer="91"/>
<label x="246.38" y="35.56" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="37"/>
</segment>
</net>
<net name="SRAM_DQ2" class="0">
<segment>
<wire x1="248.92" y1="55.88" x2="248.92" y2="35.56" width="0.1524" layer="91"/>
<label x="248.92" y="35.56" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="39"/>
</segment>
</net>
<net name="VCC_B2" class="0">
<segment>
<wire x1="99.06" y1="68.58" x2="101.6" y2="68.58" width="0.1524" layer="91"/>
<wire x1="101.6" y1="68.58" x2="104.14" y2="68.58" width="0.1524" layer="91"/>
<junction x="101.6" y="68.58"/>
<label x="88.9" y="68.58" size="1.778" layer="95"/>
<pinref part="SV9" gate="G$1" pin="2"/>
<pinref part="SV9" gate="G$1" pin="4"/>
<junction x="104.14" y="68.58"/>
</segment>
</net>
<net name="SPI_CLK" class="0">
<segment>
<wire x1="205.74" y1="73.66" x2="205.74" y2="71.12" width="0.1524" layer="91"/>
<label x="205.74" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="6"/>
</segment>
</net>
<net name="SPI_DI" class="0">
<segment>
<wire x1="208.28" y1="71.12" x2="208.28" y2="73.66" width="0.1524" layer="91"/>
<label x="208.28" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="8"/>
</segment>
</net>
<net name="SPI_SEL1" class="0">
<segment>
<wire x1="210.82" y1="71.12" x2="210.82" y2="73.66" width="0.1524" layer="91"/>
<label x="210.82" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="10"/>
</segment>
</net>
<net name="SRAM_A18" class="0">
<segment>
<wire x1="213.36" y1="71.12" x2="213.36" y2="73.66" width="0.1524" layer="91"/>
<label x="213.36" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="12"/>
</segment>
</net>
<net name="SRAM_A15" class="0">
<segment>
<wire x1="215.9" y1="71.12" x2="215.9" y2="73.66" width="0.1524" layer="91"/>
<label x="215.9" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="14"/>
</segment>
</net>
<net name="SRAM_A17" class="0">
<segment>
<wire x1="218.44" y1="71.12" x2="218.44" y2="73.66" width="0.1524" layer="91"/>
<label x="218.44" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="16"/>
</segment>
</net>
<net name="SRAM_WE" class="0">
<segment>
<wire x1="220.98" y1="71.12" x2="220.98" y2="73.66" width="0.1524" layer="91"/>
<label x="220.98" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="18"/>
</segment>
</net>
<net name="SRAM_A13" class="0">
<segment>
<wire x1="223.52" y1="71.12" x2="223.52" y2="73.66" width="0.1524" layer="91"/>
<label x="223.52" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="20"/>
</segment>
</net>
<net name="SRAM_A8" class="0">
<segment>
<wire x1="226.06" y1="71.12" x2="226.06" y2="73.66" width="0.1524" layer="91"/>
<label x="226.06" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="22"/>
</segment>
</net>
<net name="SRAM_A9" class="0">
<segment>
<wire x1="228.6" y1="71.12" x2="228.6" y2="73.66" width="0.1524" layer="91"/>
<label x="228.6" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="24"/>
</segment>
</net>
<net name="SRAM_A11" class="0">
<segment>
<wire x1="231.14" y1="71.12" x2="231.14" y2="73.66" width="0.1524" layer="91"/>
<label x="231.14" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="26"/>
</segment>
</net>
<net name="SRAM_OE" class="0">
<segment>
<wire x1="233.68" y1="71.12" x2="233.68" y2="73.66" width="0.1524" layer="91"/>
<label x="233.68" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="28"/>
</segment>
</net>
<net name="SRAM_A10" class="0">
<segment>
<wire x1="236.22" y1="71.12" x2="236.22" y2="73.66" width="0.1524" layer="91"/>
<label x="236.22" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="30"/>
</segment>
</net>
<net name="SRAM_DQ7" class="0">
<segment>
<wire x1="238.76" y1="71.12" x2="238.76" y2="73.66" width="0.1524" layer="91"/>
<label x="238.76" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="32"/>
</segment>
</net>
<net name="SRAM_DQ6" class="0">
<segment>
<wire x1="241.3" y1="71.12" x2="241.3" y2="73.66" width="0.1524" layer="91"/>
<label x="241.3" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="34"/>
</segment>
</net>
<net name="SRAM_DQ5" class="0">
<segment>
<wire x1="243.84" y1="71.12" x2="243.84" y2="73.66" width="0.1524" layer="91"/>
<label x="243.84" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="36"/>
</segment>
</net>
<net name="SRAM_DQ4" class="0">
<segment>
<wire x1="246.38" y1="71.12" x2="246.38" y2="73.66" width="0.1524" layer="91"/>
<label x="246.38" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="38"/>
</segment>
</net>
<net name="SRAM_DQ3" class="0">
<segment>
<wire x1="248.92" y1="71.12" x2="248.92" y2="73.66" width="0.1524" layer="91"/>
<label x="248.92" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="40"/>
</segment>
</net>
<net name="SPI_DO" class="0">
<segment>
<wire x1="203.2" y1="73.66" x2="203.2" y2="71.12" width="0.1524" layer="91"/>
<label x="203.2" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="4"/>
</segment>
</net>
<net name="SPI_SEL0" class="0">
<segment>
<wire x1="200.66" y1="71.12" x2="200.66" y2="73.66" width="0.1524" layer="91"/>
<label x="200.66" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV8" gate="G$1" pin="2"/>
</segment>
</net>
<net name="VCC_CORE" class="0">
<segment>
<wire x1="200.66" y1="55.88" x2="203.2" y2="55.88" width="0.1524" layer="91"/>
<label x="200.66" y="50.8" size="1.778" layer="95" rot="R270"/>
<wire x1="200.66" y1="55.88" x2="200.66" y2="50.8" width="0.1524" layer="91"/>
</segment>
</net>
<net name="VCC_B0" class="0">
<segment>
<wire x1="208.28" y1="55.88" x2="205.74" y2="55.88" width="0.1524" layer="91"/>
<label x="204.724" y="50.292" size="1.778" layer="95" rot="R270"/>
<pinref part="SV8" gate="G$1" pin="5"/>
<wire x1="205.74" y1="55.88" x2="205.74" y2="50.8" width="0.1524" layer="91"/>
<junction x="205.74" y="55.88"/>
</segment>
</net>
<net name="VCC_B1" class="0">
<segment>
<label x="210.82" y="50.8" size="1.778" layer="95" rot="R270"/>
<wire x1="210.82" y1="55.88" x2="213.36" y2="55.88" width="0.1524" layer="91"/>
<pinref part="SV8" gate="G$1" pin="9"/>
<junction x="210.82" y="55.88"/>
<wire x1="210.82" y1="55.88" x2="210.82" y2="50.8" width="0.1524" layer="91"/>
</segment>
</net>
<net name="G0" class="0">
<segment>
<label x="116.84" y="48.26" size="1.778" layer="95" rot="R270"/>
<pinref part="SV9" gate="G$1" pin="13"/>
<wire x1="116.84" y1="48.26" x2="116.84" y2="53.34" width="0.1524" layer="91"/>
</segment>
</net>
<net name="B1" class="0">
<segment>
<label x="119.38" y="48.26" size="1.778" layer="95" rot="R270"/>
<pinref part="SV9" gate="G$1" pin="15"/>
<wire x1="119.38" y1="48.26" x2="119.38" y2="53.34" width="0.1524" layer="91"/>
</segment>
</net>
<net name="B0" class="0">
<segment>
<label x="121.92" y="48.26" size="1.778" layer="95" rot="R270"/>
<pinref part="SV9" gate="G$1" pin="17"/>
<wire x1="121.92" y1="48.26" x2="121.92" y2="53.34" width="0.1524" layer="91"/>
</segment>
</net>
<net name="CSYNC" class="0">
<segment>
<label x="124.46" y="48.26" size="1.778" layer="95" rot="R270"/>
<pinref part="SV9" gate="G$1" pin="19"/>
<wire x1="124.46" y1="48.26" x2="124.46" y2="53.34" width="0.1524" layer="91"/>
</segment>
</net>
<net name="AUDLEFT" class="0">
<segment>
<label x="127" y="48.26" size="1.778" layer="95" rot="R270"/>
<pinref part="SV9" gate="G$1" pin="21"/>
<wire x1="127" y1="48.26" x2="127" y2="53.34" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$99" class="0">
<segment>
<label x="132.08" y="48.26" size="1.778" layer="95" rot="R270"/>
<pinref part="SV9" gate="G$1" pin="25"/>
<wire x1="132.08" y1="48.26" x2="132.08" y2="53.34" width="0.1524" layer="91"/>
</segment>
</net>
<net name="B_DEBUG" class="0">
<segment>
<label x="134.62" y="48.26" size="1.778" layer="95" rot="R270"/>
<pinref part="SV9" gate="G$1" pin="27"/>
<wire x1="134.62" y1="48.26" x2="134.62" y2="53.34" width="0.1524" layer="91"/>
</segment>
</net>
<net name="B_NMI" class="0">
<segment>
<label x="137.16" y="48.26" size="1.778" layer="95" rot="R270"/>
<pinref part="SV9" gate="G$1" pin="29"/>
<wire x1="137.16" y1="48.26" x2="137.16" y2="53.34" width="0.1524" layer="91"/>
</segment>
</net>
<net name="AUDRIGHT" class="0">
<segment>
<label x="129.54" y="48.26" size="1.778" layer="95" rot="R270"/>
<pinref part="SV9" gate="G$1" pin="23"/>
<wire x1="129.54" y1="48.26" x2="129.54" y2="53.34" width="0.1524" layer="91"/>
</segment>
</net>
<net name="CASIN" class="0">
<segment>
<label x="139.7" y="48.26" size="1.778" layer="95" rot="R270"/>
<pinref part="SV9" gate="G$1" pin="31"/>
<wire x1="139.7" y1="48.26" x2="139.7" y2="53.34" width="0.1524" layer="91"/>
</segment>
</net>
<net name="PS2CLK" class="0">
<segment>
<wire x1="149.86" y1="73.66" x2="149.86" y2="68.58" width="0.1524" layer="91"/>
<label x="149.86" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV9" gate="G$1" pin="40"/>
<junction x="149.86" y="68.58"/>
</segment>
</net>
<net name="PS2DAT" class="0">
<segment>
<wire x1="147.32" y1="73.66" x2="147.32" y2="68.58" width="0.1524" layer="91"/>
<label x="147.32" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV9" gate="G$1" pin="38"/>
<junction x="147.32" y="68.58"/>
</segment>
</net>
<net name="CASMOTOR" class="0">
<segment>
<wire x1="144.78" y1="73.66" x2="144.78" y2="68.58" width="0.1524" layer="91"/>
<label x="144.78" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV9" gate="G$1" pin="36"/>
<junction x="144.78" y="68.58"/>
</segment>
</net>
<net name="CASOUT" class="0">
<segment>
<wire x1="142.24" y1="73.66" x2="142.24" y2="68.58" width="0.1524" layer="91"/>
<label x="142.24" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV9" gate="G$1" pin="34"/>
<junction x="142.24" y="68.58"/>
</segment>
</net>
<net name="KBROW3" class="0">
<segment>
<wire x1="139.7" y1="73.66" x2="139.7" y2="68.58" width="0.1524" layer="91"/>
<label x="139.7" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV9" gate="G$1" pin="32"/>
<junction x="139.7" y="68.58"/>
</segment>
</net>
<net name="KBROW2" class="0">
<segment>
<wire x1="137.16" y1="73.66" x2="137.16" y2="68.58" width="0.1524" layer="91"/>
<label x="137.16" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV9" gate="G$1" pin="30"/>
<junction x="137.16" y="68.58"/>
</segment>
</net>
<net name="KBROW1" class="0">
<segment>
<wire x1="134.62" y1="73.66" x2="134.62" y2="68.58" width="0.1524" layer="91"/>
<label x="134.62" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV9" gate="G$1" pin="28"/>
<junction x="134.62" y="68.58"/>
</segment>
</net>
<net name="KBROW0" class="0">
<segment>
<wire x1="132.08" y1="73.66" x2="132.08" y2="68.58" width="0.1524" layer="91"/>
<label x="132.08" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV9" gate="G$1" pin="26"/>
<junction x="132.08" y="68.58"/>
</segment>
</net>
<net name="FLASHFREEZE" class="0">
<segment>
<wire x1="111.76" y1="73.66" x2="111.76" y2="68.58" width="0.1524" layer="91"/>
<label x="111.76" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV9" gate="G$1" pin="10"/>
<junction x="111.76" y="68.58"/>
</segment>
</net>
<net name="KBCOL0" class="0">
<segment>
<wire x1="109.22" y1="73.66" x2="109.22" y2="68.58" width="0.1524" layer="91"/>
<label x="109.22" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV9" gate="G$1" pin="8"/>
<junction x="109.22" y="68.58"/>
</segment>
</net>
<net name="KBCOL1" class="0">
<segment>
<wire x1="114.3" y1="73.66" x2="114.3" y2="68.58" width="0.1524" layer="91"/>
<label x="114.3" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV9" gate="G$1" pin="12"/>
<junction x="114.3" y="68.58"/>
</segment>
</net>
<net name="KBCOL2" class="0">
<segment>
<wire x1="116.84" y1="73.66" x2="116.84" y2="68.58" width="0.1524" layer="91"/>
<label x="116.84" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV9" gate="G$1" pin="14"/>
<junction x="116.84" y="68.58"/>
</segment>
</net>
<net name="KBCOL3" class="0">
<segment>
<wire x1="119.38" y1="73.66" x2="119.38" y2="68.58" width="0.1524" layer="91"/>
<label x="119.38" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV9" gate="G$1" pin="16"/>
<junction x="119.38" y="68.58"/>
</segment>
</net>
<net name="KBCOL4" class="0">
<segment>
<wire x1="121.92" y1="73.66" x2="121.92" y2="68.58" width="0.1524" layer="91"/>
<label x="121.92" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV9" gate="G$1" pin="18"/>
<junction x="121.92" y="68.58"/>
</segment>
</net>
<net name="KBCOL5" class="0">
<segment>
<wire x1="124.46" y1="73.66" x2="124.46" y2="68.58" width="0.1524" layer="91"/>
<label x="124.46" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV9" gate="G$1" pin="20"/>
<junction x="124.46" y="68.58"/>
</segment>
</net>
<net name="KBCOL6" class="0">
<segment>
<wire x1="127" y1="73.66" x2="127" y2="68.58" width="0.1524" layer="91"/>
<label x="127" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV9" gate="G$1" pin="22"/>
<junction x="127" y="68.58"/>
</segment>
</net>
<net name="KBCOL7" class="0">
<segment>
<wire x1="129.54" y1="73.66" x2="129.54" y2="68.58" width="0.1524" layer="91"/>
<label x="129.54" y="73.66" size="1.778" layer="95" rot="R90"/>
<pinref part="SV9" gate="G$1" pin="24"/>
<junction x="129.54" y="68.58"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
</eagle>
