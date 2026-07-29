-- TwoPoint Radar Detector integration for wk_wars2x.
-- Copy this file into the wk_wars2x resource folder and load it after cl_radar.lua.

exports('DetectorExport', function()
    if type(RADAR) ~= 'table' then
        return nil
    end

    local power = false
    local poweringUp = false
    local frontXmit = false
    local rearXmit = false

    if type(RADAR.IsPowerOn) == 'function' then
        power = RADAR:IsPowerOn() == true
    elseif RADAR.vars then
        power = RADAR.vars.power == true
    end

    if type(RADAR.IsPoweringUp) == 'function' then
        poweringUp = RADAR:IsPoweringUp() == true
    elseif RADAR.vars then
        poweringUp = RADAR.vars.poweringUp == true
    end

    if type(RADAR.IsAntennaTransmitting) == 'function' then
        frontXmit = RADAR:IsAntennaTransmitting('front') == true
        rearXmit = RADAR:IsAntennaTransmitting('rear') == true
    elseif RADAR.vars and RADAR.vars.antennas then
        frontXmit = RADAR.vars.antennas.front and RADAR.vars.antennas.front.xmit == true or false
        rearXmit = RADAR.vars.antennas.rear and RADAR.vars.antennas.rear.xmit == true or false
    end

    return {
        power = power,
        poweringUp = poweringUp,
        antennas = {
            front = { xmit = frontXmit },
            rear = { xmit = rearXmit }
        }
    }
end)
