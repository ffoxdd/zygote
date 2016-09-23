Zygote.define(
  model_class: SeededModel,
  attributes: {id: 1, name: "simple model"}
)

Zygote.define(
  model_class: SeededModel,
  name: :named_model,
  attributes: {id: 2, name: "named model"}
)

Zygote.define(
  model_class: SeededModel,
  keys: [:name],
  attributes: {name: "keyed model"}
)
