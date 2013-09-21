namespace"trit"{
	namespace"fileio"{
		class"BaseFile"{
		    	metamethod"_init"
		    	:body(function(self,strFilePath)
		    		self.strFilePath = strFilePath
		    		self.numFile = 0
		    		self.booError = false
		    		self.strError = ""
		    	end);
		    	
		    	method"Open"
		    	:body(function(self,strMode)
		    		local num = 0
		    		num, self.strError = _EXFOPEN(self.strFilePath,strMode)
		    		if num == -1 then
		    			self.booError = true
		    			self.numFile = num
		    		else
		    			self.booEroor = false
			    		self.numFile = num
		    		end
		    	end);
		    	
		    	method"GetString"
		    	:body(function(self)
		    		self:Open("r")
		    		
		    		local strBuffer = {}
		    		if not(self.booError) then		    			
		    			local i = 0
		    			repeat
		    				i = i + 1
		    				strBuffer[i] = _EXFGETS(self.numFile)
		    			until strBuffer[i] == nil
			    		self:Close()
			    		local strFull = ""
			    		for i = 1, table.getn(strBuffer) do
			    			strFull = strFull .. strBuffer[i]
			    		end
			    		return strFull
		    		else
		    			return self.strError
		    		end
		    		
		    	end);
		    	
		    	method"Close"
		    	:body(function(self)
		    		if not self.booError then	
		    			_EXFCLOSE(self.numFile)
		    		end
		    	end);
		};
	}
}