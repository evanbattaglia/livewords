defmodule Livewords.Corpus do
  # Mostly based on toki pona words
  @critical_modifiers ~w[not not not extremely highly very]
  @modifiers ~w[absent ancient artful blue communal complete crummy difficult evil energetic hot large masculine mobile slightly round upper verbal]
  @extended_modifiers ["abundant","active","adult","air-like","also","another","artful","auditory","away","back","bad","big","black","cold","colourful","complex","confident","cooked","correct","crazy","cute","cyclical","dark","deadly","different","dirty","domestic","done","double","drunk","elevated","equal","ethereal","even","fatal","few","fierce","filthy","finished","foolish","formal","fresh","fun","future","gaseous","good","hard","hearing","human","important","indeed","inner","intense","internal","leading","less","light green","little","long","love","lunar","main","many","metal","missing","more","moving","much","necessary","negative","neighbouring","new","nice","numerous","only","operating","overly","parental","past","permanent","personal","positive","public","recreational","red","religious","remaining","right","same","sedentary","several","shared","short","silly","similar","simple","sleeping","sleepy","small","societal","sole","solid","somebody's","stationary","strange","strong","stupid","superior","sure","sweet","talking","tall","too","uncooked","unhealthy","urban","visual","warm","weird","white","working","work-related","wrong","yellow","young"]

  @verbs ["change","keep","pollute","personalize","contain","play","summon","enable","use","colour","listen","lead","chill","reduce","watch","consume","kill","amuse","love","open","break","do","give","feel","darken","finish","improve","heat","renew","draw","know","sweeten","move","say","strike","unite","strengthen","remove","must","should","want to","wish to","will","try to","don't","can't","can","need to"]

  @basic_nouns ~w[beast candy device fluid friend hero life light person shop sound stone stuff sun tale thing vegetable woman]
  @extended_nouns ["ability","above","absence","accident","activity","air","amount","amphibian","animal","anybody","anything","area","argument","arm","arrival","art","attack","badness","ball","bark","battle","beginning","being","below","beneath","bird","blow","blunder","body","bottom","bowl","box","breaking","brother","bug","building","bump","button","capital","card","cause","center","cereal","chain","chair","chance","chest","circle","clay","cloth","clothing","cold","colour","communication","community","company","competition","conflict","container","cord","country","cup","currency","custom","cycle","damage","darkness","death","deed","destruction","difference","dirt","disharmony","doctrine","dollar","door","duration","earth","element","emotion","end","energy","entertainment","event","everything","evil","exchange","eye","fabric","face","father","feelings","fight","filth","fire","fish","flat and bendable thing","floor","food","foot","front","fruit","fun","furniture","game","garbage","giving","glass","good","grain","group","gum","hair","hand","happening","hard thing","having","head","heart","heat","herb","hill","hip","hole","home","horizontal surface","house","human","image","indoor constructed space","inner world","insect","inside","intelligence","I/O","juice","knowledge","land","land mammal","language","leaf","leg","liquid","long","lovable animal","love","lower part","machine","manner","market","material wealth","meal","metal","method","mind","mineral","mistake","moment","money","moon","mother","mountain","mouth","movement","mushroom","name","negation","negativity","noise","non-cute animal","nose","nothing","number","object","orifice","origin","outside","over","paint","paper","parent","part","particle","paste","path","peel","people","period of time","permission","physical or verbal violence","physical state","picture","piece","pillow","plant","playing","pollution","positivity","possibility","powder","power","power","project","quantity","recreation","reptile","road","rock","room","rope","sauce","sea creature","semi-solid or squishy substance","shadows","shape","shell","side","simplicity","situation","size","skin","smell","society","somebody","something","soul","speech","sphere","spider","stick","stomach","strength","string","surface","system","table","talking","universe","thread","ticket","time","tip","tool","top","torso","transfer","transportation","tree","under","understanding","unit","voice","wall","war","warmth","water","way","wheel","wind","window","winged animal","wisdom","wood","word","work","zero"]

  defp take_random(_list, n) when n <= 0, do: []
  defp take_random(list, n), do: Enum.take_random(list, n)

  def new_modifiers(n) do
    mods =
      Enum.uniq(take_random(@critical_modifiers, Enum.random(0..3)))
      ++ take_random(@modifiers, Enum.random(round(n/5)..round(n/2)))
    mods = mods ++ take_random(@extended_modifiers, n - length(mods))
    Enum.slice mods, 0, n
  end

  def new_nouns(n) do
    basic = take_random(@basic_nouns, Enum.random(1..round(n/2)))
    extended = take_random(@extended_nouns, n - length(basic))
    Enum.sort(basic ++ extended)
  end

  def new_verbs(n), do: take_random(@verbs, n)
  
  @templates %{
    person: [
      "They embody the ~s ~s",
      "They are the ~s ~s",
      "Oh, a ~s ~s!",
    ],
    place: [
      "It embodies the ~s ~s",
      "It is the ~s ~s",
      "Oh, a ~s ~s!",
      {:verbs, "It's where you ~s the ~s"}
    ],
    story: [
    ],
  }

  @guesses_templates [
    person: [
      "They've got the same vibe as",
      "They're nothing like",
      "They look a lot like",
      "They're sorta similar to",
      "It's more specific than",
    ],
    place: [
      "It's got the same vibe as",
      "It's nothing like",
      "It's in the same class of places as",
      "It's sorta similar to",
      "It's more specific than",
    ],
    story: [
      "It's got the same vibe as",
      "It's nothing like",
      "It's in the same genre as",
      "It's sorta similar to",
      "It has the same characters as",
      "It's more specific than",
    ]
  ]

  @doc """
  Returns {template, modifiers, nouns}
  """
  def new_palette(type, n_modifiers, n_nouns, guesses) do
    templates =
      if length(guesses) > n_nouns / 2 do
        [:guesses | @templates[type]]
      else
        @templates[type]
      end

    case Enum.random(templates) do
      :guesses -> {"~s ~s", @guesses_templates[type], Enum.slice(guesses, 0..(n_nouns-1))}
      {:verbs, template} -> {template, new_verbs(n_modifiers), new_nouns(n_nouns)}
      template -> {template, new_modifiers(n_modifiers), new_nouns(n_nouns)}
    end
  end
end

