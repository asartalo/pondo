require 'timeout'

server_pid = File.read('tmp/pids/server.pid').strip.to_i
puts "SERVER PID: #{server_pid}"

begin
	Process.kill 2, server_pid
	Timeout.timeout(20) do
		while Process.kill 0, server_pid
			puts "waiting"
			sleep 1
		end
	end
rescue Errno::ESRCH
	puts "Server exited. PID: #{server_pid}"
rescue Timeout::Error
	puts "Server exit timeout. Kill -9"
	Process.kill 9, server_pid
end

puts "Done"

