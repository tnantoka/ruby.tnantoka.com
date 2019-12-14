# frozen_string_literal: true

# https://github.com/ruby-processing/JRubyArt/blob/39b17889d53a54e3761c4b29e87425e692f4ec17/src/main/java/monkstone/MathToolModule.java#L48
def map1d(val, range1, range2)
  value = val.to_f
  first1 = range1.first.to_f
  first2 = range2.first.to_f
  last1 = range1.last.to_f
  last2 = range2.last.to_f
  map_mt(value, first1, last1, first2, last2)
end

# https://github.com/ruby-processing/JRubyArt/blob/39b17889d53a54e3761c4b29e87425e692f4ec17/src/main/java/monkstone/MathToolModule.java#L179
def map_mt(value, first1, last1, first2, last2)
  first2 + (last2 - first2) * ((value - first1) / (last1 - first1))
end
