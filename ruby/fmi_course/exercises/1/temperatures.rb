def convert_between_temperature_units(degrees, from_unit, to_unit)
  # We have following unit choices: 'C', 'K' and 'F'
  # (n) C = (n - 273.15) K
  # (n) C = ((n - 32) / 1.8) F
  if from_unit == 'K'
    degrees -= 273.15
  elsif from_unit == 'F'
    degrees = (degrees - 32) / 1.8
  end

  # `degrees` are already in `C`
  if to_unit == 'K'
    degrees + 273.15
  elsif to_unit == 'F'
    (degrees * 1.8) + 32
  else
    degrees
  end
end


def melting_point_of_substance(substance_name, unit)
  melting_points_in_celsium = {
    'water' => 0,
    'ethanol' => -114,
    'gold' => 1064,
    'silver' => 961.8,
    'copper' => 1085,
  }
  degrees_in_celsium = melting_points_in_celsium[substance_name]
  if unit == 'C'
    degrees_in_celsium
  else
    convert_between_temperature_units(degrees_in_celsium, 'C', unit)
  end
end


def boiling_point_of_substance(substance_name, unit)
  boiling_points_in_celsium = {
    'water' => 100,
    'ethanol' => 78.37,
    'gold' => 2700,
    'silver' => 2162,
    'copper' => 2567,
  }
  degrees_in_celsium = boiling_points_in_celsium[substance_name]
  if unit == 'C'
    degrees_in_celsium
  else
    convert_between_temperature_units(degrees_in_celsium, 'C', unit)
  end
end
