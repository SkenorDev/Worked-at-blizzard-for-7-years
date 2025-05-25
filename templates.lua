cardTemplates = {
  WoodenCow      = {"Wooden Cow", 1, 1, "Vanilla",nil},
  Pegasus        = {"Pegasus", 3, 5, "Vanilla", nil},
  Minotaur       = {"Minotaur", 5, 9, "Vanilla", nil},
  Titan          = {"Titan", 6, 12, "Vanilla",nil},
 Zeus           = {"Zeus", 4, 5, "When Revealed:\nLower the power of\neach card in your\nopponent's hand by 1.",zeus},
  -- Ares           = {"Ares", 2, 2, "When Revealed: Gain +2 power for each enemy card here."},
 -- Medusa         = {"Medusa", 3, 4, "When ANY other card is played here, lower that card's power by 1."},
  --Cyclops        = {"Cyclops", 6, 11, "When Revealed: Discard your other cards here, gain +2 power for each discarded."},
 -- Poseidon       = {"Poseidon", 3, 4, "When Revealed: Move away an enemy card here with the lowest power."},
  Artemis        = {"Artemis", 4, 4, "When Revealed:\nGain +5 power if\nthere is exactly\none enemy card\nhere.",artemis},
  Hera           = {"Hera", 4, 5, "When Revealed:\n Give cards in your hand +1 power.",hera},
--  Demeter        = {"Demeter", 1, 1, "When Revealed: Both players draw a card."},
  Hades          = {"Hades", 6, 1, "When Revealed:\nGain +2 power for\neach card in your\ndiscard pile.",hades},
  Hercules       = {"Hercules", 3, 4, "When Revealed:\nDoubles its power if\nit's the strongest\ncard here.",hercules},
  Dionysus       = {"Dionysus", 2, 3, "When Revealed:\nGain +2 power for\neach of\nyour other cards\nhere.",dionysus},
--  Hermes         = {"Hermes", 2, 2, "When Revealed: Moves to another location."},
 -- Hydra          = {"Hydra", 3, 4, "Add two copies to your hand when this card is discarded."},
--  ShipOfTheseus  = {"Ship of Theseus", 2, 2, "When Revealed: Add a copy with +1 power to your hand."},
 -- SwordOfDamocles = {"Sword of Damocles", 6, 13, "End of Turn: Loses 1 power if not winning this location."},
  Midas          = {"Midas", 5, 3, "When Revealed:\nSet ALL cards here\nto 3 power.",midas},
  Aphrodite      = {"Aphrodite", 5, 5, "When Revealed:\nLower the power of each\nenemy card here by 1.",aphrodite},
--  Athena         = {"Athena", 1, 0, "Gain +1 power when you play another card here."},
 -- Apollo         = {"Apollo", 2, 3, "When Revealed: Gain +1 mana next turn."},
  Hephaestus     = {"Hephaestus", 3, 3, "When Revealed:\nLower the cost of 2\ncards in your hand\nby 1.",hephaestus},
  Persephone     = {"Persephone", 5, 10, "When Revealed:\nDiscard the lowest power\ncard in your\nhand.",persephone},
 -- Prometheus     = {"Prometheus", 6, 11, "When Revealed: Draw a card from your opponent's deck."},
 -- Pandora        = {"Pandora", 6, 13, "When Revealed: If no ally cards are here, lower this card's power by 5."},
 -- Icarus         = {"Icarus", 2, 1, "End of Turn: Gains +1 power, but is discarded when its power is greater than 7."},
--  Iris           = {"Iris", 5, 8, "End of Turn: Give your cards at each other location +1 power if they have unique powers."},
--  Nyx            = {"Nyx", 4, 2, "When Revealed: Discards your other cards here, add their power to this card."},
--  Altas          = {"Altas", 2, 5, "End of Turn: Loses 1 power if your side of this location is full."},
 -- Daedalus       = {"Daedalus", 3, 4, "When Revealed: Add a Wooden Cow to each other location."},
--  Helios         = {"Helios", 3, 10, "End of Turn: Discard this."},
 -- Mnemosyne      = {"Mnemosyne", 5, 5, "When Revealed: Add a copy of the last card you played to your hand."}
}
function createCard(name)
  local template = cardTemplates[name]
  if not template then
    error("Card template for " .. name .. " not found!")
  end

  return CardClass:new(template[1], template[2], template[3], template[4],template[5])
end