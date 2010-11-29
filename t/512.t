use strict;
use warnings;
use Test::More tests => 68;
use Digest::BLAKE qw(blake_512 blake_512_hex);

my $len = 0;

while (my $line = <DATA>) {
    chomp $line;
    my ($msg, $digest) = split '\|', $line, 2;
    my $data = pack 'H*', $msg;
    $digest = lc $digest;

    if ($len and not $len % 8) {
        my $md = Digest::BLAKE->new(512)->add($data)->hexdigest;
        is($md, $digest, "new/add/hexdigest: $len bits of $msg");
        is(
            blake_512_hex($data), $digest,
            "blake_512_hex: $len bits of $msg"
        );
        ok(
            blake_512($data) eq pack('H*', $digest),
            "blake_512: $len bits of $msg"
        );
    }

    my $md = Digest::BLAKE->new(512)->add_bits($data, $len)->hexdigest;
    is($md, $digest, "new/add_bits/hexdigest: $len bits of $msg");
}
continue { $len++ }

__DATA__
00|223D88A8C8308C15D479D1668BA97B1B2737AAD82DEBD7D05D32F77A13F820651C36FC9EB18E2101B8E992717E671400BE6A7F158CDD64AFED6F81E62BF15C37
00|9AB06D7216AA01E8EE61F95D9001E1EF627E71D49127C6B36EDFFB8AE427530090021A96D73ACFA061CB26D67950AD59A7C3BFBD30DAD844C9349CF8E1A0C838
C0|AFE0D4563A0D1B90B61F4EC673D9B1820C37CD23413D09B1907C4CA25B8901F9B4BDC7FA6C9F434FB031642F7E98104D5E26DB525659B73D757D208CEDCF1A35
C0|73A2BC75A5489979C783B3B2D686F0EFC7B198006B023AE0325E865D70EC3BBDF88535E1728CCA27DBD9705D994169F23A56235652E55FD6BBBC87B87B19ED7A
80|7D75B98D9F1FDD528684F8FF92AFB14AE45C59B5510AA42AC67F49DC00FD1F9D49F0B5A612CBE1F7996D14418A1E6805E221FCACB7369C8D158D6A6C1E9A381E
48|8366D46A00FF46D226FAF8587D3025A6695D2FC9B006943E0D50E3E8C55186517B1B3693AF7B7A60CA758837313349E0FC406D532E65B23D06DE7328091CBD8C
50|EB71357082606BF996E863C0227DC9294A64BA0418C9C53CA4441952047493F7E5479A93D68A9CCEC4BD5F14C50CA3F31F2F4CA91E1E7CC6E57A3729F6A5711C
98|DAC0513CB98AADAC0B15CECE5C286C5985B568FAEA3D3E2EAEEA2A1B80180E049FA2F50E6E753C036C6106EC22DDF1D6ACAAAABB8031655498D0B425778D36C4
CC|00C0894F5C73AA36D24373CC2BB9BD7CA8E76159625FCDC0604ED1BAE3CF407B639B260128D9E40DEAA813C4E721CB765EDE7C971B37AB8986A50711DA94DE57
9800|C9AA072C44C1AB89DFE2A92E17ED8F790FE74789B6065384149D30E065E45456F2B4DF5050A833BA6258081B4B3605220896457F666E76771CB35906218F31E5
9D40|FC1CD82494AC35EB42C3CA39031973E1DE6F6026C9D5769FF6CF5344A12C8D839683C01EFA4FC93B671791A69D97B0D6377D8B883983F427EF0B5EDB42123582
AA80|6E0E6C251D87767E5021584E9993B33E736B82D6D2748B8F5C076F4133B7F1B0BF27B3ACA5709ACB4E108523165D912670E767CEAA332B2E4C773F0A8A0A902D
9830|9C516EB50C6F750443E18815432DCCF286A1F1854070F1D2E8229983A6E78A7D65DB600B5B1152CFC5AD49AA4448B8C3D25976B3363BC19903D0DAC028AA4E0C
5030|77FEF397C81B083F0640D2F0BBDE4D140A15F8C72467C91C9AAB9EEDB7A5FCFF232590E55038C3C57FAC5B6A9E07D5BF16199143FFD094EF7461177E68720A91
4D24|11E40E9ABBFD18740F8DE86DF8B3B0D272F59BC9FA9B347FE0EF0085D8229ABA0CCC4F3F03708146AF90832848CBEB1E48A4B9DC169840C5A5DC98D035B0AFDC
CBDE|227C0B632444C93A947126B31463357F3DEF61B0E3E9FE3F2334579662351E58F9842FF848B5991F930786C7AEFA61D9945A7EB33CADAD68F5B8D36B6E982730
41FB|0CEC13240FB64C845F376F8DBA90C5324FB3EE0C7CF018E687A93663DEEC992B501FD0FB7620C170821BA3C930A98ECDBB4E717B79CA35F2F195C5766159C656
4FF400|FC2FB43CE06B8F43784F696AD2231C47A30D5B3698A2384D32D64E7B4F62495AE706A627E200923FF9B7A2A529071A927DA8296DF4DA24817E00A3E32F842959
FD0440|5157BB77B60BC57D063207B4F07A4607DDB75D6FF7B799D8244FA9E7F04D6C6E9E3347B69CAC94D467167E04C42CEAB0347BA3CDF9FD450DF4D3DA94B5F2D5ED
424D00|B214F6808C439640A5C73D804F928EE67543AF3DDBAEC1AB62AB9B4BA9AF9EEC942690B657B93480BB1E2B6C61E52993550EA6AFE70DFDA83B624083454AAED4
3FDEE0|58D8CD3BE8884A88D0AC5AE6D833D39B720198FC29EC6D2732F9B0C730EC30542F7163A5A4456EB20B92B722C2DF7C639A98B1AEF41610636958AFD96B029D61
335768|D6285A4CF09AA9C557238C02DBAC71B656BC4663BA8976D12AA8E63BDF1F9D81006E97328D5AFCD6A3BF992A6247798FA0BE15846221988E8F2BA17270E532B1
051E7C|F5325B18FFDECB58707D762015E98EFB343E6D84051236A52092540C6FB799E5AA72AC6E898B501FA8D83729BD3F997A3222112039FE43CB1150C15EBB9B3A6C
717F8C|1A393407609F4E9F3C24AE0F4C7997CD44E6D76835AB330ACEA7876F41862AC3B93FECC7BB012BB37924C343702611B6B5601EF2A3F00740EA4AEC6AA656427F
1F877C|3C21B927E22DA57BF13AD3224E42A2F114166AD33828B6940443C3D775661E7D2C5871C19FCB9CAF7A19CE1FD5C19C1A41070B1F4EE06F0DCD31C7D3164BBDF6
EB35CF80|10A358043FC04AA5DA50EBD030183519BCBB751137B94FD8962076D0537A58B8EEE65F166446D8A8F840D135A2C0BA71195DD8454BC3E67083441F920AFA7BB6
B406C480|4F09F39CC49A414156BF6DB6334CECE7C1CC15D49C83A2DD6C8FD37000802C34699717044DF24700B9E7410A08973A4F7605AB213835E28F9F1699EAB4B6B0F3
CEE88040|EA2B6D481E246CBF0741F82BAFA02B5D7A536BBE7D3988E47D905995F08975533A448E52181EB425370212C5336CC32BF64065D6EA77E8BBBA982F87CE6663D7
C584DB70|F5CA0BB5EE026CD003BB64584BCF7222E5B2768B75FA0C4078277143FBB5EEBB9F7F4632E93327C116E6ADA4C92661B67B211F61E809CAFF712B986B6E573817
53587BC8|10B2DF0E294B5AF05F7E829C9FAEA0135565C3E4F928802A1758C672792D8BD22E722240AE0E11557161694B77D1A4B35D6F093C07D688C50D70F1DDCD3FCCA1
69A305B0|9B1CE56AE7BC2F83CB2D2EDA45949BB2D72D7815144AC71C040035F0BB26480E1A9966EFD67B1C235EE007E7017F3806A15720A2F722F07C18E534119B33C229
C9375ECE|F9A6ADC4B81F26228ADEC0887BE8DBB0470B2001D09EFCB0FD5EEF2674164E01D28C77D5535FE00D255135C57A9DF3E72D5D838E11072711B40B29859C3F11F4
C1ECFDFC|ACF0B1AE0605B1BFFF35B64DA587C99FE17E907FE92A05ED460F08AD3B1F6D6AA3F8BC752CE398E45C5789AD77FC4DA5DFA63E903F32F5C65FAC22DEC26E3994
8D73E8A280|B4EEF790AEA1CF389A33AE364F4D4670A54D05985E3B4CF6CD3126FA21B3AF1FF2CCA0F9B16A1C4190F0D70EB0686D9F3683082D33B66CC5162DBCE7FF983138
06F2522080|A3D0AC66256A958EB1D4187EE4F683A7503F937FDEFA5E8E71B81BF7639E7D0142FE2869C3FB8371784D00A391F23E2DE9CBB49DC996F7E53CC098968B5A74E2
3EF6C36F20|CFB6DE2F22A6EF1B845AC9D12D56CE18CFB47BAB331755CFE6620E27BCBDFE83568D21B586FABD1D39890B36149D3C9422805C1E90F93FC0D5F0E7B5A7406490
0127A1D340|D22535416FEC72CBB64028F7743DDF9036434E7569F32B0382BABB6CA0AF3B0E7650EFCE193D851517C8BF723D87951CF780658A6DD80A4CE7F76773F562BAFB
6A6AB6C210|B4D139226994152FC64FD7885CA14C1F311B4C0EF9634C53263B4174BA37D5B38BCEFD8DBCF5DB8E3F212AFBD083C3EB5E9B6BA3A91634CD92DC75E2CB3DF329
AF3175E160|09C0A722E6D9C53A72A361D9ACD316685F710A5BED2BF50DB43F1386555FDAEE9FFB0C9F685CBC75B5CEA148772C7EB2E0C06472617695B20719909E8D7EFBC6
B66609ED86|BB624C427E5407FBDC81D81ED114E0095680DACAB1B129120B9BA5F1996DAFAA9FC059BED37E65388075BE7E1C0D32B66D0E3440BC9D55291DE88FFC5D6F69A5
21F134AC57|8C704867BE68FE7EF056F27B6F9CA754ED4479BD735A5E8C97CA8EA18107824DCD8442DF6B02670787B7733F16022A235B6B4E838B43278BA3248CA6D8A82E6B
3DC2AADFFC80|C756C4B3E8563AE1B39A49B9A165AD8C80A4045A8E337C79590558CCC45EBB1A1C658C2AAD53DAF848AAED0FB6E01F2F07BEF7642EAE7D1F1A8E92964309C86B
9202736D2240|C40701A679C830F5885D3A0529E340168BAF64DB98A6540075BEDE8A12A86D9D1C30D89717EF07B144B91041E88FE691B91D014A159481965D9B8EA331558030
F219BD629820|BF3757C016C4CFED4F948A154124FB9D79144BBBCE3FC628DFE25C842EEF07C20AF874B3BAF4804539B01BEF999422900848CC9E2A338B7A7804A21F9D5E56F7
F3511EE2C4B0|9327DD70D2B9496384EBDF50DA563C071F87875009CAB053FF04B3F8BE6FA318A08B324A0D2112036AC43864D165695EE4C9D65B9E418248710F39B5BFA6F4AC
3ECAB6BF7720|6973FBD79FDCF144218CE6F10AC5E64A4E8D9D19658DC5CB94237123633DF260D4F8276BCA2E8A367FEAB20C056ABAFF1EC2964D317583C3AF75A079F5B56FC2
CD62F688F498|66FDF1B2A3875877BD77159D059749C2D8F9E7757BBDB675D0A1A8A2CDFDCEF83640966783624C2FFDFC6225F41436B4019F4941A59D3D5E57D7DBD6CCAA9DCB
C2CBAA33A9F8|1108A0975E7D9AB7CDE7DE6DC8C2C33A518D5D144A3F0617C0942CF124C639C3998DA4C96B6252173C9803343370EBDF26F707E4FDB4C7F1A5E30016C17BBC58
C6F50BB74E29|28EC131FE6943C73B0DB96F0B75D10C27665307A3A963723E350A87C70D56729AFFEBE6B791FA46D6B267ECEA3383AE949B649C8DAC9CECAE973968C566586D0
79F1B4CCC62A00|4ADF3CA38002D5B7CEB4F61147003A2A94815A5E1A639E20A996A06DF38DBC4CD158861833733D714ECE5556E01EA8F355CF7C836A0911FF97621759806116DC