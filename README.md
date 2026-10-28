# tentacle

**One capability bit from GBT V8, packaged standalone.** No. 303 of 341,
`tentacle` domain (Tentacle).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> 触手/眼睛/双手/手：默认调本体原生能力，给意图自动命中，不给方法名也行；桌面动作见 see/read_text/click/type/list_windows（**条目数现算，见 tentacle_manifest**，不手写）

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-tentacle.git
cd gbt-tentacle
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_tentacle info                  # capability card
python -m gbt_tentacle spec --json           # machine-readable contract
python -m gbt_tentacle check --payload '{"action": "<在此填写>"}'
python -m gbt_tentacle run   --payload '{"action": "<在此填写>"}'
```

Real `info` output from this machine:

```text
tentacle  (tentacle)  v1.0.0
----------------------------------------
触手/眼睛/双手/手：默认调本体原生能力，给意图自动命中，不给方法名也行；桌面动作见 see/read_text/click/type/list_windows（**条目数现算，见 tentacle_manifest**，不手写）

gated      : False
external   : False
multi-op   : True
params     : action
             触手能力名；或给 intent 走自动路由、op=caps 看全部
values     : see, read_text, click, type, list_windows
```

Wire a real implementation:

```python
from gbt_tentacle import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({"action": "<在此填写>"}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| `action` | yes | declared required by the registry |

Registry hint (`params_hint`): 触手能力名；或给 intent 走自动路由、op=caps 看全部

**注册表登记的取值 / 子动作（5 个）**：`see`、`read_text`、`click`、`type`、`list_windows`

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Not gated: the registry marks this bit `safe: true`.
- No external service dependency declared.
- Multi-op (`multi_op: true`): several sub-actions share one name — read `op` before calling.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
22 passed, 1 skipped in 0.14s
```

## Provenance

| field | value |
|---|---|
| capability | `tentacle` |
| domain | `tentacle` |
| handler | `tentacle` |
| safe | `True` (gated = `False`) |
| external | `False` |
| atlas page | [tentacle/tentacle](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/tentacle/tentacle.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
