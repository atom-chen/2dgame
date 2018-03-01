
-- press 'z' will do this file
zcg.logTable(cc.Scheduler, "e:/a.txt")


Socket.SendPacket(Opcode.MSG_CS_GMCommand, {
        command = "exp, fuck me"
    }, function(tab)
        print(tab.result)
        table.print(tab)
    end)
