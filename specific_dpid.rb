class Test < Controller

	#~ def switch_ready (datapath_id)
		#~ info "Switch #{ datapath_id.to_hex } is UP"
	#~ end
	
	def switch_ready (datapath_id)
	@host1_ip = Pio::IPv4Address.new("192.168.1.1")
	@host1_mac = Pio::Mac.new("54:ee:75:70:ff:d7")
	@host2_ip = Pio::IPv4Address.new("192.168.1.2")
	@host2_mac = Pio::Mac.new("54:ee:75:70:58:bc")
	@broadcast_mac = Pio::Mac.new("ff:ff:ff:ff:ff:ff")
		
		info "Switch #{ datapath_id.to_hex } is UP"
		if datapath_id == 2

			send_flow_mod_add(
				datapath_id,
				:match => Match.new(:dl_dst => @host1_mac),
				:actions => ActionOutput.new( :port => 2 )
				)
			send_flow_mod_add(
				datapath_id,
				:match => Match.new(:dl_dst => @host2_mac ),
				:actions => ActionOutput.new( :port => 1 )
				)
			send_flow_mod_add(
				datapath_id,
				:match => Match.new(:dl_dst => @broadcast_mac ),
				:actions => ActionOutput.new( OFPP_FLOOD )
				)
		end
	end
end
