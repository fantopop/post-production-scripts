FasdUAS 1.101.10   ��   ��    k             l     ��������  ��  ��        l     �� 	 
��   	 ' ! AppleScripts for Avid Pro Tools.    
 �   B   A p p l e S c r i p t s   f o r   A v i d   P r o   T o o l s .      l     ��������  ��  ��        l     ��  ��      Script description:     �   (   S c r i p t   d e s c r i p t i o n :      l     ��  ��    ? 9 Clicks on Detect button of the Auto-Align track plug-in.     �   r   C l i c k s   o n   D e t e c t   b u t t o n   o f   t h e   A u t o - A l i g n   t r a c k   p l u g - i n .      l     ��������  ��  ��        l     ��  ��      � 2017 Ilya Putilin     �   (   �   2 0 1 7   I l y a   P u t i l i n       l     �� ! "��   ! !  http://github.com/fantopop    " � # # 6   h t t p : / / g i t h u b . c o m / f a n t o p o p    $ % $ l     �� & '��   &       ' � ( (    %  ) * ) l     ��������  ��  ��   *  + , + l     -���� - I    �� .��
�� .miscactvnull��� ��� null . m      / /�                                                                                  PTul  alis    X  Macintosh HD               �(��H+  1tPro Tools.app                                                  �!��t        ����  	                Applications    �(��      ��D    1t  (Macintosh HD:Applications: Pro Tools.app    P r o   T o o l s . a p p    M a c i n t o s h   H D  Applications/Pro Tools.app  / ��  ��  ��  ��   ,  0�� 0 l   � 1���� 1 O    � 2 3 2 O   
 � 4 5 4 k    � 6 6  7 8 7 l   �� 9 :��   9 ; 5 Check whether there is an open track plug-in window.    : � ; ; j   C h e c k   w h e t h e r   t h e r e   i s   a n   o p e n   t r a c k   p l u g - i n   w i n d o w . 8  < = < r    # > ? > I   !�� @��
�� .corecnte****       **** @ l    A���� A 6    B C B 2   ��
�� 
cwin C E     D E D 1    ��
�� 
pnam E m     F F � G G & P l u g - i n :   A u t o - A l i g n��  ��  ��   ? o      ���� 0 aaopen AAOpen =  H I H l  $ $��������  ��  ��   I  J K J Z   $ L L M���� L A   $ ' N O N o   $ %���� 0 aaopen AAOpen O m   % &����  M k   * H P P  Q R Q I  * E�� S T
�� .sysodlogaskr        TEXT S m   * + U U � V V V C a n ' t   f i n d   A u t o - A l i g n   t r a c k   p l u g - i n   w i n d o w . T �� W X
�� 
btns W J   , / Y Y  Z�� Z m   , - [ [ � \ \  O K��   X �� ] ^
�� 
dflt ] J   0 3 _ _  `�� ` m   0 1 a a � b b  O K��   ^ �� c d
�� 
disp c m   6 9��
�� stic    d �� e��
�� 
appr e m   < ? f f � g g " A p p l e S c r i p t   e r r o r��   R  h�� h L   F H����  ��  ��  ��   K  i j i l  M M��������  ��  ��   j  k l k l  M M�� m n��   m   Get Detect button.    n � o o &   G e t   D e t e c t   b u t t o n . l  p q p r   M ` r s r l  M \ t���� t 6  M \ u v u 4 M Q�� w
�� 
cwin w m   O P����  v E   R [ x y x 1   S U��
�� 
pnam y m   V Z z z � { { & P l u g - i n :   A u t o - A l i g n��  ��   s o      ���� 0 trackwindow trackWindow q  | } | r   a o ~  ~ n   a k � � � 4   d k�� �
�� 
sgrp � m   g j � � � � �  F X T D M E d i t V i e w � o   a d���� 0 trackwindow trackWindow  o      ���� 0 
aaeditview 
AAEditView }  � � � r   p ~ � � � n   p z � � � 4   s z�� �
�� 
sliI � m   v y � � � � �  D e t e c t � o   p s���� 0 
aaeditview 
AAEditView � o      ���� 0 detectbutton detectButton �  � � � l   ��������  ��  ��   �  � � � l   �� � ���   � #  Detect button current state.    � � � � :   D e t e c t   b u t t o n   c u r r e n t   s t a t e . �  � � � r    � � � � n    � � � � 1   � ���
�� 
valL � o    ����� 0 detectbutton detectButton � o      ���� 0 detectenabled detectEnabled �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �   Toggle.    � � � �    T o g g l e . �  ��� � Z   � � � ��� � � =   � � � � � o   � ����� 0 detectenabled detectEnabled � m   � �����   � I  � ��� ���
�� .prcsperfnull���     actT � n   � � � � � 4   � ��� �
�� 
actT � m   � � � � � � �  A X I n c r e m e n t � o   � ����� 0 detectbutton detectButton��  ��   � I  � ��� ���
�� .prcsperfnull���     actT � n   � � � � � 4   � ��� �
�� 
actT � m   � � � � � � �  A X D e c r e m e n t � o   � ����� 0 detectbutton detectButton��  ��   5 4   
 �� �
�� 
prcs � m     � � � � �  P r o   T o o l s 3 m     � ��                                                                                  sevs  alis    �  Macintosh HD               �(��H+  1USystem Events.app                                              .���MX        ����  	                CoreServices    �(��      ��#(    1U1T1S  =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  ��  ��  ��       �� � ���   � ��
�� .aevtoappnull  �   � **** � �� ����� � ���
�� .aevtoappnull  �   � **** � k     � � �  + � �  0����  ��  ��   �   � $ /�� ��� ��� ��� F���� U�� [�� a������ f���� z���� ����� ��������� ��� �
�� .miscactvnull��� ��� null
�� 
prcs
�� 
cwin �  
�� 
pnam
�� .corecnte****       ****�� 0 aaopen AAOpen
�� 
btns
�� 
dflt
�� 
disp
�� stic   
�� 
appr�� 
�� .sysodlogaskr        TEXT�� 0 trackwindow trackWindow
�� 
sgrp�� 0 
aaeditview 
AAEditView
�� 
sliI�� 0 detectbutton detectButton
�� 
valL�� 0 detectenabled detectEnabled
�� 
actT
�� .prcsperfnull���     actT�� ��j O� �*��/ �*�-�[�,\Z�@1j 	E�O�k #���kv��kva a a a a  OhY hO*�k/�[�,\Za @1E` O_ a a /E` O_ a a /E` O_ a ,E` O_ j  _ a  a !/j "Y _ a  a #/j "UUascr  ��ޭ