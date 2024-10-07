-- @description ImportSessionData_GUI
-- @author MPL
-- @website http://forum.cockos.com/member.php?u=70694
-- @noindex

  ---------------------------------------------------
  function rect(x,y,w,h)
    gfx.x,gfx.y = x,y
    gfx.lineto(x,y+h)
    gfx.x,gfx.y = x+1,y+h
    gfx.lineto(x+w,y+h)
    gfx.x,gfx.y = x+w,y+h-1
    gfx.lineto(x+w,y)
    gfx.x,gfx.y = x+w-1,y
    gfx.lineto(x+1,y)
  end
  ---------------------------------------------------
  function col(obj, col_str, a) 
    local r,g,b= table.unpack(obj.GUIcol[col_str])
    gfx.set(r,g,b ) 
    --if not GetOS():match('Win') then gfx.set(b,g,r ) end
    if a then gfx.a = a end  
  end

  
  ---------------------------------------------------
  function GUI_knob(obj, b)
    local x,y,w,h,val =b.x,b.y,b.w,b.h, b.val
    if not val then return end
    local arc_r = math.floor(w/2 * 0.7)
    if b.reduce_knob then arc_r = arc_r*b.reduce_knob end
    y = y - arc_r/2 + 1
    local ang_gr = 120
    local ang_val = math.rad(-ang_gr+ang_gr*2*val)
    local ang = math.rad(ang_gr)
    local thickness = 1.5
    local knob_y_shift = b.knob_y_shift
    if not knob_y_shift then knob_y_shift = 0 end
    
    col(obj, b.col, 0.08)
    if b.knob_as_point then 
      local y = y - 5
      local arc_r = arc_r*0.75
      for i = 0, thickness, 0.5 do
        gfx_arc(x+w/2,y+h/2+ knob_y_shift,arc_r-i, -ang_gr, ang_gr, ang_gr)
      end
      gfx.a = 0.02
      gfx.circle(x+w/2,y+h/2,arc_r, 1)
      return 
    end
    
    
    -- arc back      
    col(obj, b.col, 0.15)
    local halfh = math.floor(h/2)
    local halfw = math.floor(w/2)
    for i = 0, thickness, 0.5 do
      gfx_arc(x+w/2,y+h/2+ knob_y_shift,arc_r-i, -ang_gr, ang_gr, ang_gr)
    end
    
    
    
    local knob_a = 0.6
    if b.knob_a then knob_a = b.knob_a end
    col(obj, b.col, knob_a)      
    if not b.is_centered_knob then 
      -- val       
      local ang_val = -ang_gr+ang_gr*2*val
      for i = 0, thickness, 0.5 do
        gfx_arc(x+w/2,y+h/2+ knob_y_shift,arc_r-i, -ang_gr, ang_val, ang_gr)
      end
      
     else -- if centered
      for i = 0, thickness, 0.5 do
        if val< 0.5 then
          gfx_arc(x+w/2,y+h/2 + knob_y_shift,arc_r-i, -ang_gr+ang_gr*2*val, 0, ang_gr)
         elseif val> 0.5 then
          gfx_arc(x+w/2,y+h/2+ knob_y_shift,arc_r-i, 0, -ang_gr+ang_gr*2*val, ang_gr)
        end
      end    
          
    end 
  end
  ---------------------------------------------------
  function gfx_arc(x,y,r, start_ang0, end_ang0, lim_ang, y_shift0)
    local start_ang = start_ang0
    local end_ang = end_ang0
    local y_shift = y_shift0
    if not y_shift0 then y_shift = 0 end
    local x = math.floor(x)
    local y = math.floor(y)
    local has_1st_segm = (start_ang <= -90) or (end_ang <= -90)
    local has_2nd_segm = (start_ang > -90 and start_ang <= 0) or (end_ang > -90 and end_ang <= 0) or (start_ang<=-90 and end_ang >= 0 )
    local has_3rd_segm = (start_ang >= 0 and start_ang <= 90) or (end_ang > 0 and end_ang <= 90) or (start_ang<=0 and end_ang >= 90 )
    local has_4th_segm = (start_ang > 90) or (end_ang > 90)
    
    if has_1st_segm then  gfx.arc(x,y+1 +y_shift,r, math.rad(math.max(start_ang,-lim_ang)), math.rad(math.min(end_ang, -90)),    1) end
    if has_2nd_segm then  gfx.arc(x,y+y_shift,r, math.rad(math.max(start_ang,-90)), math.rad(math.min(end_ang, 0)),    1) end
    if has_3rd_segm then gfx.arc(x+1,y+y_shift,r, math.rad(math.max(start_ang,0)), math.rad(math.min(end_ang, 90)),    1) end
    if has_4th_segm then  gfx.arc(x+1,y+1+y_shift,r, math.rad(math.max(start_ang,90)), math.rad(math.min(end_ang, lim_ang)),    1)  end
  end
  ---------------------------------------------------
  function GUI_DrawObj(obj, o, mouse, conf)
    if not o then return end
    gfx.dest = 1
    local x,y,w,h, txt = o.x, o.y, o.w, o.h, o.txt
    --gfx.set(1,1,1,1)gfx.rect(x,y,w,h,0)   
    if not x or not y or not w or not h then return end
    if o.alpha_back then gfx.a = o.alpha_back end
    
    if not o.disable_blitback then
      gfx.a = 0.3
      local blit_h, blit_w = obj.grad_sz,obj.grad_sz
      gfx.blit( 5, 1, 0, -- grad back
              0,0,  blit_w,blit_h,
              x,y,w,h, 0,0) 
    end   
    
    
    ------------------ fill back
      local x_sl = x      
      local w_sl = w 
      local y_sl = y      
      local h_sl = h 
      if o.fillback == true then
        local r, g, b
        if o.fillback_colint and tonumber(o.fillback_colint) then r, g, b = ColorFromNative( tonumber(o.fillback_colint) ) gfx.set(r/255,g/255,b/255, o.fillback_a) end 
        if o.fillback_colstr then col(obj, o.fillback_colstr, o.fillback_a) end 
        gfx.rect(x,y,w,h,1) 
      end
      
      if o.selected then
        gfx.set(1,1,1,1)
        gfx.rect(x,y,w,h, 0)
      end
    --[[ color fill
      if not o.colfill_frame and o.colfill_col then
        col(obj, o.colfill_col, o.colfill_a or 1) 
        gfx.rect(x,y,w,h,1)   
       elseif    o.colfill_frame and o.colfill_col  then
        gfx.a = 0.8
        local blit_h, blit_w = obj.grad_sz,obj.grad_sz
        gfx.blit( 5, 1, 0, -- grad back
              0,math.rad(180),  blit_w,blit_h,
              x,y,w,h, 0,0)   
        col(obj, o.colfill_col, o.colfill_a*0.7 or 1) 
        gfx.rect(x,y,w,h,1)                    
      end]]
             
    ------------------ check
    local check_ex = ((type(o.check)=='boolean' and o.check==true) or (o.check and o.check&1==1))
                        or ((type(o.check)=='boolean' and o.check==false) or (o.check and o.check&1==0))
    --if o.check then
      gfx.a = 0.7
      if (type(o.check)=='boolean' and o.check==true) or (o.check and o.check&1==1 and o.check~=-1) then
        local xr = x+2
        local yr = y+2
        local wr = h-6
        local hr = h-5
        gfx.rect(xr,yr,wr,hr,1)
        rect(x,y,h-3,h-2,0)
       elseif (type(o.check)=='boolean' and o.check==false) or (o.check and o.check&1==0 and o.check~=-1) then
        rect(x,y,h-3,h-2,0)
       elseif o.check and o.check==-1 then

        gfx.line(x+h-3,y,x,y)        
        gfx.line(x,y+1,x,y+h-4) 
      end
    --end
      
    
    ------------------ tab
      if o.is_tab and o.col then
        col(obj, o.col, 0.6)
        local tab_cnt = o.is_tab >> 7
        local cur_tab = o.is_tab & 127
        gfx.line( x+cur_tab*w/tab_cnt,y,
                  x+w/tab_cnt*(1+cur_tab),y)
        gfx.line( x+cur_tab*w/tab_cnt,y+h,
                  x+w/tab_cnt*(1+cur_tab),y+h)                  
      end
    
    ------------------ knob
      if o.is_knob then GUI_knob(obj, o) end
  
    ------------------ txt
    -- text 
      local txt
      if not o.txt then txt = '' else txt = tostring(o.txt) end
      --if not o.txt then txt = '>' else txt = o.txt..'|' end
      ------------------ txt
        if txt and w > 0 then 
          if o.txt_col then col(obj, o.txt_col)else col(obj, 'white') end
          if o.txt_a then 
            gfx.a = o.txt_a 
            if o.outside_buf then gfx.a = o.txt_a*0.8 end
           else 
            gfx.a = 0.8 
          end
          gfx.setfont(1, obj.GUI_font, o.fontsz or obj.GUI_fontsz )
          local shift = 2
          local cnt = 0
          for line in txt:gmatch('[^\r\n]+') do cnt = cnt + 1 end
          local com_texth = gfx.texth*cnt
          local i = 0
          local reduce1, reduce2 = 2, nil
          if o.aligh_txt and o.aligh_txt&8==8 then reduce1, reduce2 = 0,-2 end
            local txt_t = {}
            
            if not o.txt_wrap then 
              for line in txt:gmatch('[^\r\n]+') do txt_t[#txt_t+1] = line end
             else
              local lim_wr = 10
              for line in txt:gmatch('[^\r\n]+') do 
                if gfx.measurestr(line) > w -lim_wr then 
                  local str = ''
                  for symb = 1, string.len(line) do
                    str = str..line:sub(symb,symb)
                    if gfx.measurestr(str) > w -lim_wr then 
                      txt_t[#txt_t+1] = str
                      str = ''
                    end
                  end
                  txt_t[#txt_t+1] = str
                 else
                  txt_t[#txt_t+1] = line
                end   
              end
            end
            
            local comy_shift = ((#txt_t-1) * gfx.texth)/2
            for lineid = 1, #txt_t do
              local line = txt_t[lineid]
              if gfx.measurestr(line:sub(2)) > w -5 and w > 20 then                 
                repeat line = line:sub(reduce1, reduce2) until gfx.measurestr(line..'...') < w -5
                if o.aligh_txt and o.aligh_txt&8==8 then line = line..'...' else line = '...'..line end                
              end
              gfx.x = x+ math.ceil((w-gfx.measurestr(line))/2)
              gfx.y = y+ h/2 - com_texth/2 + i*gfx.texth - comy_shift
              if o.aligh_txt then
                if o.aligh_txt&1==1 then 
                  gfx.x = x + shift 
                  if check_ex then gfx.x = gfx.x + o.h end
                end -- align left
                if o.aligh_txt&2==2 then gfx.y = y + i*gfx.texth end -- align top
                if o.aligh_txt&4==4 then gfx.y = h - com_texth+ i*gfx.texth-shift end -- align bot
                if o.aligh_txt&8==8 then gfx.x = x + w - gfx.measurestr(line) - shift end -- align right
                if o.aligh_txt&16==16 then gfx.y = y + (h - com_texth)/2+ i*gfx.texth - 2 end -- align center
              end
              gfx.drawstr(line)
              --shift = shift + gfx.texth
              i = i + 1
            end
            
        end                


      
    ------------------ frame
      if o.a_frame and o.col then  -- low frame
        col(obj, o.col, o.a_frame or 0.2)
        gfx.rect(x,y,w,h,0)
        gfx.x,gfx.y = x,y
        gfx.lineto(x,y+h)
        gfx.x,gfx.y = x+1,y+h
        --gfx.lineto(x+w,y+h)
        gfx.x,gfx.y = x+w,y+h-1
        --gfx.lineto(x+w,y)
        gfx.x,gfx.y = x+w-1,y
        gfx.lineto(x+1,y)
      end    

    -- highlight
    if o.is_selected then
      col(obj, 'white', 0.2)
      --gfx.rect(x,y,w,h,1)
      gfx.a = 0.4
      local h0 = math.floor(h/2)
      gfx.blit( 3, 1, math.rad(180), -- grad back
                0,0,  obj.grad_sz,obj.grad_sz,
                x,y,w,h0, 0,0)  
      gfx.blit( 3, 1, 0, -- grad back
                0,0,  obj.grad_sz,obj.grad_sz,
                x,y+h0,w,h0, 0,0)                  
    end
      
    
    return true
  end
  ---------------------------------------------------
  function GUI_DrawLine(x1,y1,x2,y2)
    gfx.line(x1,y1,x2,y2)
  end
---------------------------------------------------  
  function GUI_gradBack(conf, obj, data, refresh, mouse)
    -- com grad
    gfx.dest = 2
    gfx.setimgdim(2, -1, -1)  
    gfx.setimgdim(2, obj.grad_sz,obj.grad_sz)  
    local r,g,b,a = 1,1,1,0.72
    gfx.x, gfx.y = 0,0
    local c = 0.8
    local drdx = c*0.00001
    local drdy = c*0.00001
    local dgdx = c*0.00008
    local dgdy = c*0.0001    
    local dbdx = c*0.00008
    local dbdy = c*0.00001
    local dadx = c*0.0001
    local dady = c*0.0001       
    gfx.gradrect(0,0, obj.grad_sz,obj.grad_sz, 
                    r,g,b,a, 
                    drdx, dgdx, dbdx, dadx, 
                    drdy, dgdy, dbdy, dady) 
  end
  
    ---------------------------------------------------  
  function GUI_gradDrawObj(conf, obj, data, refresh, mouse)
    gfx.dest = 5
    gfx.setimgdim(5, -1, -1)  
    gfx.setimgdim(5, obj.grad_sz,obj.grad_sz)  
    local r,g,b,a = 1,1,1,0.5
    gfx.x, gfx.y = 0,0
    local c = 1
    local drdx = c*0.001
    local drdy = c*0.01
    local dgdx = c*0.001
    local dgdy = c*0.001    
    local dbdx = c*0.00003
    local dbdy = c*0.001
    local dadx = c*0.0004
    local dady = c*0.0001       
    gfx.gradrect(0,0, obj.grad_sz,obj.grad_sz, 
                    r,g,b,a, 
                    drdx, dgdx, dbdx, dadx, 
                    drdy, dgdy, dbdy, dady) 
                    gfx.dest = -1  
  end    
  ---------------------------------------------------  
  function GUI_gradSelection(conf, obj, data, refresh, mouse)
        gfx.dest = 3
        gfx.setimgdim(3, -1, -1)  
        gfx.setimgdim(3, obj.grad_sz,obj.grad_sz)  
        local r,g,b,a = 1,1,1,0.2
        gfx.x, gfx.y = 0,0
        local c = 0.8
        local drdx = c*0.00001
        local drdy = c*0.00001
        local dgdx = c*0.00008
        local dgdy = c*0.00001    
        local dbdx = c*0.00008
        local dbdy = c*0.00001
        local dadx = c*0.0005
        local dady = c*0.003       
        gfx.gradrect(0,0, obj.grad_sz,obj.grad_sz, 
                        r,g,b,a, 
                        drdx, dgdx, dbdx, dadx, 
                        drdy, dgdy, dbdy, dady)  
  end 
  ---------------------------------------------------   
  function GUI_Pattern(conf, obj, data, refresh, mouse, strategy)
    if not obj.pat_workarea or not strategy.ref_pattern_len or not obj.pat_workarea.w then return end
    local beatw = obj.pat_workarea.w / strategy.ref_pattern_len
    gfx.set(1,1,1,0.2)
    for i = 1, strategy.ref_pattern_len do
      gfx.line( obj.pat_workarea.x + beatw * (i-1), 
                obj.pat_workarea.y + obj.pat_workarea.h+obj.grid_area,
                obj.pat_workarea.x + beatw * (i-1),
                obj.pat_workarea.y + obj.pat_workarea.h +obj.grid_area*(1-0.7))
    end
    gfx.a = 0.15
    gfx.rect( obj.pat_workarea.x,
              obj.pat_workarea.y+obj.pat_workarea.h+2,
              obj.pat_workarea.w,
              obj.grid_area+1,1)
    
    if data.ref_pat then
      local grid_h = 11
      col(obj, 'green')
      gfx.a = 0.45
      for i = 1, #data.ref_pat do
        local norm_pos = data.ref_pat[i].pos / strategy.ref_pattern_len
        local norm_val = data.ref_pat[i].val
        gfx.line( obj.pat_workarea.x + norm_pos * obj.pat_workarea.w, 
                  obj.pat_workarea.y+obj.pat_workarea.h-1,
                  obj.pat_workarea.x + norm_pos * obj.pat_workarea.w, 
                  obj.pat_workarea.y+obj.pat_workarea.h - math.floor(obj.pat_workarea.h *norm_val))
      end
    end
  end
    ---------------------------------------------------
  function GUI_draw(conf, obj, data, refresh, mouse, strategy)
    gfx.mode = 0
    
    -- 1 main
    -- 2 gradient back
    --  3 grad selection
    -- 5 gradient Draw Obj\
    
    --  init
      if refresh.GUI_onStart then
        GUI_gradBack(conf, obj, data, refresh, mouse)
        GUI_gradDrawObj(conf, obj, data, refresh, mouse)
        GUI_gradSelection(conf, obj, data, refresh, mouse)
        refresh.GUI_onStart = nil             
        refresh.GUI = true       
      end
      
    -- refresh
      if refresh.GUI then 
        --[[ wires
          gfx.dest = 4
          gfx.setimgdim(4, -1, -1)  
          gfx.setimgdim(4, gfx.w, gfx.h)   
      ]]          
        -- refresh backgroung
          gfx.dest = 1
          gfx.setimgdim(1, -1, -1)  
          gfx.setimgdim(1, gfx.w, gfx.h) 
          gfx.blit( 2, 1, 0, -- grad back
                    0,0,  obj.grad_sz,obj.grad_sz/2,
                    0,0,  gfx.w,gfx.h, 0,0)                
        -- refresh all buttons
          for key in spairs(obj) do 
            if type(obj[key]) == 'table' and obj[key].show and not obj[key].blit then 
              GUI_DrawObj(obj, obj[key], mouse, conf) 
            end  
          end  
      end
    
 
      
    --  render    
      gfx.dest = -1   
      gfx.a = 1
      gfx.x,gfx.y = 0,0
      --gfx.set(1,1,1,0.2)
      --gfx.rect(0,0,gfx.w, gfx.h/4,1)
    --  back
      gfx.blit(4, 1, 0, -- backgr
          0,0,gfx.w, gfx.h,
          0,0,gfx.w, gfx.h, 0,0)      
      gfx.blit(1, 1, 0, -- backgr
          0,0,gfx.w, gfx.h,
          0,0,gfx.w, gfx.h, 0,0)  

    
    refresh.GUI = nil
    refresh.GUI_minor = nil
    gfx.update()
  end

