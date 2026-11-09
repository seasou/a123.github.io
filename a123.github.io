<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no,viewport-fit=cover">
<meta name="theme-color" content="#0b0f0d">
<title>云水间 · 网络静修</title>
<style>
  *{box-sizing:border-box;}
  html,body{
    margin:0;height:100%;overflow:hidden;background:#0b0f0d;
    font-family:-apple-system,BlinkMacSystemFont,"PingFang SC","Microsoft YaHei",sans-serif;
    -webkit-tap-highlight-color:transparent;user-select:none;-webkit-user-select:none;
    touch-action:none;
  }
  #c{position:fixed;inset:0;width:100%;height:100%;display:block;}

  /* ---------- 顶部法名 ---------- */
  .topbar{
    position:fixed;top:0;left:0;right:0;
    padding:calc(12px + env(safe-area-inset-top)) 16px 0;
    display:flex;justify-content:space-between;align-items:flex-start;
    pointer-events:none;z-index:10;
  }
  .nameplate{
    color:#e8dfcc;font-size:12px;letter-spacing:.18em;
    background:rgba(10,16,13,.42);
    backdrop-filter:blur(8px);-webkit-backdrop-filter:blur(8px);
    padding:9px 14px;border-radius:3px;
    border:1px solid rgba(200,180,140,.16);
    box-shadow:0 2px 18px rgba(0,0,0,.4),inset 0 1px 0 rgba(255,240,200,.06);
  }
  .nameplate b{
    color:#d9b96a;font-weight:500;letter-spacing:.3em;
    text-shadow:0 0 10px rgba(217,185,106,.35);
  }

  /* ---------- 动作按钮 ---------- */
  .acts{
    position:fixed;right:16px;bottom:calc(24px + env(safe-area-inset-bottom));
    display:flex;flex-direction:column;gap:10px;z-index:10;
  }
  .acts button{
    width:58px;height:58px;border-radius:50%;
    border:1px solid rgba(210,190,150,.2);
    background:rgba(14,22,18,.55);
    backdrop-filter:blur(8px);-webkit-backdrop-filter:blur(8px);
    color:#d8cfb8;font-size:10px;letter-spacing:.08em;
    display:flex;flex-direction:column;align-items:center;justify-content:center;gap:3px;
    cursor:pointer;padding:0;transition:transform .16s,background .16s,box-shadow .16s;
    font-family:inherit;
    box-shadow:0 3px 16px rgba(0,0,0,.35),inset 0 1px 0 rgba(255,240,200,.05);
  }
  .acts button .ico{font-size:17px;line-height:1;filter:saturate(.7);}
  .acts button:active{transform:scale(.9);background:rgba(217,185,106,.2);box-shadow:0 0 22px rgba(217,185,106,.25);}
  .acts button.dis{opacity:.35;pointer-events:none;}

  /* ---------- 摇杆 ---------- */
  .stick{
    position:fixed;left:26px;bottom:calc(30px + env(safe-area-inset-bottom));
    width:110px;height:110px;border-radius:50%;
    border:1px solid rgba(210,190,150,.14);
    background:radial-gradient(circle at 50% 45%,rgba(30,44,34,.35),rgba(14,22,18,.22));
    backdrop-filter:blur(4px);-webkit-backdrop-filter:blur(4px);
    z-index:10;touch-action:none;
    box-shadow:inset 0 0 24px rgba(0,0,0,.35);
  }
  .knob{
    position:absolute;left:50%;top:50%;width:44px;height:44px;
    margin:-22px 0 0 -22px;border-radius:50%;
    background:radial-gradient(circle at 38% 32%,rgba(240,215,150,.42),rgba(160,125,55,.20));
    border:1px solid rgba(217,185,106,.38);
    box-shadow:0 0 16px rgba(217,185,106,.18),inset 0 1px 2px rgba(255,240,200,.3);
    transition:transform .06s;
  }

  /* ---------- 念珠面板 ---------- */
.panel{
  position:fixed;left:0;right:0;bottom:0;z-index:20;
  padding:14px 18px calc(20px + env(safe-area-inset-bottom));
  background:linear-gradient(to top,rgba(8,12,10,.97) 40%,rgba(8,12,10,0));
  transform:translateY(105%);
  transition:transform .34s cubic-bezier(.22,1,.36,1);
}
.panel.on{transform:translateY(0);}

.panel-close{
  position:absolute;right:14px;top:10px;z-index:2;
  width:34px;height:34px;border-radius:50%;
  border:1px solid rgba(210,190,150,.18);
  background:rgba(20,28,24,.62);
  color:#a89e88;font-size:14px;line-height:1;padding:0;
  display:flex;align-items:center;justify-content:center;
  cursor:pointer;font-family:inherit;
  backdrop-filter:blur(6px);-webkit-backdrop-filter:blur(6px);
  transition:background .16s,color .16s,transform .16s;
}
.panel-close:active{background:rgba(217,185,106,.22);color:#d9b96a;transform:scale(.9);}

.mala{
  position:relative;width:232px;height:232px;
  margin:0 auto 8px;cursor:pointer;touch-action:manipulation;
}
.mala::before{
  content:'';position:absolute;inset:26px;border-radius:50%;
  border:1px solid rgba(217,185,106,.09);
  background:radial-gradient(circle,rgba(217,185,106,.09),transparent 72%);
  box-shadow:inset 0 0 40px rgba(217,185,106,.06);
  pointer-events:none;
  animation:malaGlow 7s ease-in-out infinite;
}
@keyframes malaGlow{
  0%,100%{opacity:.7;}
  50%{opacity:1;}
}
.mala::after{
  content:'';position:absolute;left:50%;bottom:6px;margin-left:-6px;
  border-left:6px solid transparent;
  border-right:6px solid transparent;
  border-bottom:8px solid rgba(217,185,106,.45);
  pointer-events:none;
  filter:drop-shadow(0 0 6px rgba(217,185,106,.5));
}

.bead-pos{
  position:absolute;left:50%;top:50%;width:0;height:0;
  transition:transform .42s cubic-bezier(.34,1.25,.5,1);
  will-change:transform;
}
.bead{
  position:absolute;left:0;top:0;
  width:17px;height:17px;margin:-8.5px 0 0 -8.5px;
  border-radius:50%;
  background:radial-gradient(circle at 34% 28%,#7a6136,#2b2110);
  border:1px solid rgba(0,0,0,.55);
  box-shadow:inset 0 1px 1px rgba(255,220,150,.18),0 1px 3px rgba(0,0,0,.5);
  transition:transform .18s ease,background .3s,box-shadow .3s;
}
.bead.master{
  width:23px;height:23px;margin:-11.5px 0 0 -11.5px;
  background:radial-gradient(circle at 34% 28%,#b8944a,#3a2c14);
  border-color:rgba(217,185,106,.48);
  box-shadow:0 0 10px rgba(217,185,106,.25),inset 0 1px 2px rgba(255,235,180,.35);
}
.bead-pos.active .bead{
  background:radial-gradient(circle at 34% 28%,#f7e2a4,#a67c2a);
  box-shadow:0 0 16px rgba(240,210,130,.6),inset 0 1px 2px rgba(255,248,220,.65);
}
.bead.pluck{transform:scale(1.6);}

.mala-center{
  position:absolute;left:50%;top:50%;transform:translate(-50%,-50%);
  text-align:center;pointer-events:none;
}
.mala-count{
  font-size:32px;line-height:1;color:#d9b96a;
  font-variant-numeric:tabular-nums;letter-spacing:.02em;
  text-shadow:0 0 16px rgba(217,185,106,.4);
  transition:transform .16s;
}
.mala-count.pop{transform:scale(1.18);}
.mala-label{font-size:10px;letter-spacing:.3em;color:#6b6450;margin-top:7px;}

.beadinfo{text-align:center;color:#8d846f;font-size:11px;letter-spacing:.16em;}

  /* ---------- 遮罩层 ---------- */
  .overlay{
    position:fixed;inset:0;z-index:30;
    display:flex;flex-direction:column;align-items:center;justify-content:center;gap:16px;
    color:#cfc5ac;opacity:0;pointer-events:none;background:rgba(4,8,6,0);
    transition:opacity .9s ease,background .9s ease;
    text-align:center;padding:32px;
  }
  .overlay.on{opacity:1;pointer-events:auto;background:rgba(4,8,6,.8);}

  #intro{background:radial-gradient(ellipse at 50% 45%,rgba(10,16,13,.88),rgba(4,8,6,.96));opacity:1;pointer-events:auto;z-index:40;}
  #intro .title{
    font-size:26px;letter-spacing:.6em;color:#e2d8c0;text-indent:.6em;
    text-shadow:0 0 30px rgba(217,185,106,.3);
  }
  #intro .sub{font-size:12px;letter-spacing:.28em;color:#8d846f;line-height:2.1;}
  #intro .btn{
    margin-top:18px;padding:13px 44px;border-radius:2px;
    border:1px solid rgba(217,185,106,.4);background:rgba(217,185,106,.08);
    color:#d9b96a;font-size:13px;letter-spacing:.35em;text-indent:.35em;
    cursor:pointer;font-family:inherit;transition:.25s;
  }
  #intro .btn:active{background:rgba(217,185,106,.22);box-shadow:0 0 30px rgba(217,185,106,.3);}

  .sit-time{
    font-size:32px;letter-spacing:.14em;color:#d9b96a;
    font-variant-numeric:tabular-nums;
    text-shadow:0 0 22px rgba(217,185,106,.35);
  }
  .sit-tip{font-size:11px;letter-spacing:.3em;color:#7d745f;}

  /* 坐禅呼吸圈 */
  .sit-ring{
    width:130px;height:130px;border-radius:50%;
    border:1px solid rgba(217,185,106,.22);
    position:relative;
    animation:breath 9s ease-in-out infinite;
    box-shadow:0 0 46px rgba(217,185,106,.08) inset;
  }
  .sit-ring::after{
    content:'';position:absolute;inset:16px;border-radius:50%;
    border:1px solid rgba(217,185,106,.12);
  }
  @keyframes breath{
    0%,100%{transform:scale(.84);opacity:.3;}
    50%{transform:scale(1.1);opacity:.9;}
  }

  /* ---------- 暗角 ---------- */
  .vignette{
    position:fixed;inset:0;pointer-events:none;z-index:5;
    background:radial-gradient(ellipse at 50% 45%,transparent 34%,rgba(0,0,0,.62) 100%);
  }
</style>
</head>
<body>

<canvas id="c"></canvas>
<div class="vignette"></div>

<!-- 顶部 -->
<div class="topbar">
  <div class="nameplate">法名 · <b id="faming">—</b></div>
</div>

<!-- 摇杆 -->
<div class="stick" id="stick"><div class="knob" id="knob"></div></div>

<!-- 动作 -->
<div class="acts">
  <button data-act="hand"><span class="ico">🤲</span>合掌</button>
  <button data-act="bow"><span class="ico">🙏</span>问讯</button>
  <button data-act="bead"><span class="ico">📿</span>念珠</button>
  <button data-act="sit"><span class="ico">🧘</span>坐禅</button>
</div>

<!-- 念珠 -->
<div class="panel" id="beadPanel">
  <button class="panel-close" id="beadClose" aria-label="收起念珠">✕</button>
  <div class="mala" id="mala">
    <div class="mala-center">
      <div class="mala-count" id="beadN">0</div>
      <div class="mala-label">声</div>
    </div>
  </div>
  <div class="beadinfo">轻触珠串 · 拨动一珠</div>
</div>

<!-- 坐禅 -->
<div class="overlay" id="sitOverlay">
  <div class="sit-ring"></div>
  <div class="sit-time" id="sitTime">00:00</div>
  <div class="sit-tip">静 坐 中</div>
  <div class="sit-tip" style="margin-top:24px;color:#4e4838;">点击任意处出定</div>
</div>

<!-- 开场 -->
<div class="overlay on" id="intro">
  <div class="title">云水间</div>
  <div class="sub">
    你被分到法名<br>
    <span style="font-size:22px;letter-spacing:.4em;color:#d9b96a;" id="introName">闲云</span>
  </div>
  <button class="btn" id="enterBtn">入 内</button>
  <div class="sub" style="font-size:10px;color:#5a5446;margin-top:22px;letter-spacing:.2em;">
    此处无对话 · 无点赞 · 无人可见你
  </div>
</div>

<script>
/* =========================================================
   云水间 · 网络静修  v1.1
   纯前端单文件实现，无外部依赖
   ========================================================= */

/* ---------------- 基础工具 ---------------- */
const clamp = (v, a, b) => Math.max(a, Math.min(b, v));
let _seed = 20240601;
function rnd() { _seed = (_seed * 1103515245 + 12345) & 0x7fffffff; return _seed / 0x7fffffff; }
const rndRange = (a, b) => a + rnd() * (b - a);

/* ---------------- 法名 ---------------- */
const NA = ['闲','柔','静','空','明','淡','幽','清','无','了','听','坐','行','云','月','一','半'];
const NB = ['云','月','风','水','石','松','竹','兰','溪','山','露','雪','钟','舟','鹤','苔','雾'];
function makeName() {
  return NA[Math.floor(Math.random() * NA.length)] + NB[Math.floor(Math.random() * NB.length)];
}

/* ---------------- 画布 ---------------- */
const cvs = document.getElementById('c');
const ctx = cvs.getContext('2d');
let W = 1, H = 1, DPR = 1;

function resize() {
  DPR = Math.min(window.devicePixelRatio || 1, 2);
  W = cvs.clientWidth || window.innerWidth;
  H = cvs.clientHeight || window.innerHeight;
  cvs.width = Math.round(W * DPR);
  cvs.height = Math.round(H * DPR);
  ctx.setTransform(DPR, 0, 0, DPR, 0, 0);
}

/* ---------------- 世界 ---------------- */
const WORLD = { w: 1400, h: 1000 };
const PAD = { x0: 380, y0: 400, x1: 1020, y1: 980 };

const trees = [
  { x: 140, y: 540 }, { x: 235, y: 705 }, { x: 108, y: 855 }, { x: 252, y: 965 },
  { x: 1262, y: 520 }, { x: 1345, y: 700 }, { x: 1200, y: 885 }, { x: 1352, y: 975 },
  { x: 372, y: 505 }, { x: 1028, y: 505 }, { x: 300, y: 400 }, { x: 1100, y: 400 }
];

const cushions = [
  { x: 640, y: 640 }, { x: 760, y: 640 }, { x: 700, y: 720 }
];

const stoneLamps = [
  { x: 470, y: 470 }, { x: 930, y: 470 }, { x: 340, y: 640 }, { x: 1060, y: 640 }
];

/* ---------------- 玩家 ---------------- */
const player = {
  x: 700, y: 800,
  vx: 0, vy: 0,
  speed: 210,
  face: 1,
  handAmt: 0, handTarget: 0, handTimer: 0,
  bowAmt: 0,  bowTarget: 0,  bowTimer: 0,
  sitAmt: 0,  sitting: false,
  walkPhase: 0
};

/* ---------------- 摄像机 ---------------- */
const cam = { x: 700, y: 800 };

/* ---------------- 输入 ---------------- */
const keys = Object.create(null);
const stick = { active: false, id: null, dx: 0, dy: 0 };

window.addEventListener('keydown', e => {
  keys[e.key.toLowerCase()] = true;
  if (['arrowup','arrowdown','arrowleft','arrowright',' '].includes(e.key.toLowerCase())) e.preventDefault();
});
window.addEventListener('keyup', e => { keys[e.key.toLowerCase()] = false; });

/* 虚拟摇杆 */
const stickEl = document.getElementById('stick');
const knobEl = document.getElementById('knob');
const STICK_R = 42;

function stickStart(e) {
  const t = e.changedTouches ? e.changedTouches[0] : e;
  stick.active = true;
  stick.id = t.identifier !== undefined ? t.identifier : 'mouse';
  stickMove(e);
  e.preventDefault();
}
function stickMove(e) {
  if (!stick.active) return;
  let t = null;
  if (e.changedTouches) {
    for (const c of e.changedTouches) if (c.identifier === stick.id) t = c;
    if (!t) return;
  } else t = e;

  const r = stickEl.getBoundingClientRect();
  const cx = r.left + r.width / 2;
  const cy = r.top + r.height / 2;
  let dx = t.clientX - cx;
  let dy = t.clientY - cy;
  const d = Math.hypot(dx, dy);
  if (d > STICK_R) { dx = dx / d * STICK_R; dy = dy / d * STICK_R; }
  stick.dx = dx / STICK_R;
  stick.dy = dy / STICK_R;
  knobEl.style.transform = `translate(${dx}px,${dy}px)`;
  e.preventDefault();
}
function stickEnd(e) {
  if (e.changedTouches) {
    let found = false;
    for (const c of e.changedTouches) if (c.identifier === stick.id) found = true;
    if (!found) return;
  }
  stick.active = false; stick.dx = 0; stick.dy = 0;
  knobEl.style.transform = 'translate(0,0)';
}

stickEl.addEventListener('touchstart', stickStart, { passive: false });
stickEl.addEventListener('touchmove', stickMove, { passive: false });
stickEl.addEventListener('touchend', stickEnd);
stickEl.addEventListener('touchcancel', stickEnd);
stickEl.addEventListener('mousedown', stickStart);
window.addEventListener('mousemove', stickMove);
window.addEventListener('mouseup', stickEnd);

/* =========================================================
   音频引擎 —— 全部实时合成
   ========================================================= */
let actx = null;
const A = {
  ready: false,
  master: null,
  reverb: null,
  noise: null,
  droneGain: null,
  windGain: null
};

function audio() {
  if (!actx) {
    const AC = window.AudioContext || window.webkitAudioContext;
    if (!AC) return null;
    try { actx = new AC(); } catch (e) { return null; }
    setupGraph();
  }
  if (actx.state === 'suspended') actx.resume();
  return actx;
}

/* 生成混响脉冲响应：低通噪声 + 指数衰减 */
function makeIR(dur, decay) {
  const rate = actx.sampleRate;
  const len = Math.max(1, Math.floor(rate * dur));
  const buf = actx.createBuffer(2, len, rate);
  for (let ch = 0; ch < 2; ch++) {
    const d = buf.getChannelData(ch);
    let last = 0;
    for (let i = 0; i < len; i++) {
      const t = i / len;
      const env = Math.pow(1 - t, decay);
      const n = Math.random() * 2 - 1;
      last = last * 0.62 + n * 0.38;   /* 简易低通，使混响更柔暗 */
      d[i] = last * env;
    }
  }
  return buf;
}

function makeNoise(dur) {
  const rate = actx.sampleRate;
  const len = Math.max(1, Math.floor(rate * dur));
  const b = actx.createBuffer(1, len, rate);
  const d = b.getChannelData(0);
  for (let i = 0; i < len; i++) d[i] = Math.random() * 2 - 1;
  return b;
}

function setupGraph() {
  const a = actx;

  const comp = a.createDynamicsCompressor();
  comp.threshold.value = -18;
  comp.knee.value = 26;
  comp.ratio.value = 3.2;
  comp.attack.value = 0.005;
  comp.release.value = 0.3;

  A.master = a.createGain();
  A.master.gain.value = 0.85;
  A.master.connect(comp);
  comp.connect(a.destination);

  const rev = a.createConvolver();
  rev.buffer = makeIR(3.8, 2.4);
  const revOut = a.createGain();
  revOut.gain.value = 0.62;
  rev.connect(revOut);
  revOut.connect(A.master);
  A.reverb = rev;

  A.noise = makeNoise(2.5);
  A.ready = true;
}

/* 每个音效的输出总线（干声 + 混响送出） */
function bus(vol, wet) {
  const a = actx;
  const g = a.createGain();
  g.gain.value = vol;
  g.connect(A.master);
  if (wet > 0) {
    const s = a.createGain();
    s.gain.value = wet;
    g.connect(s);
    s.connect(A.reverb);
  }
  return g;
}

/* ---------------- 木鱼 ---------------- */
function sndWood(vol = 0.22, pitch = 1) {
  const a = audio(); if (!a) return;
  const t = a.currentTime;
  const out = bus(vol, 0.28);

  /* 木体基音 */
  const f0 = 880 * pitch * (0.96 + Math.random() * 0.08);
  const o = a.createOscillator();
  o.type = 'triangle';
  o.frequency.setValueAtTime(f0, t);
  o.frequency.exponentialRampToValueAtTime(f0 * 0.44, t + 0.06);
  const g = a.createGain();
  g.gain.setValueAtTime(0.9, t);
  g.gain.exponentialRampToValueAtTime(0.0008, t + 0.15);
  o.connect(g); g.connect(out);
  o.start(t); o.stop(t + 0.17);

  /* 敲击颗粒 */
  const src = a.createBufferSource();
  src.buffer = A.noise;
  const bp = a.createBiquadFilter();
  bp.type = 'bandpass';
  bp.frequency.value = 1750 * pitch;
  bp.Q.value = 1.3;
  const ng = a.createGain();
  ng.gain.setValueAtTime(0.45, t);
  ng.gain.exponentialRampToValueAtTime(0.001, t + 0.05);
  src.connect(bp); bp.connect(ng); ng.connect(out);
  src.start(t); src.stop(t + 0.06);

  /* 空腔共鸣 */
  const o2 = a.createOscillator();
  o2.type = 'sine';
  o2.frequency.setValueAtTime(f0 * 2.15, t);
  o2.frequency.exponentialRampToValueAtTime(f0 * 1.08, t + 0.09);
  const g2 = a.createGain();
  g2.gain.setValueAtTime(0.32, t);
  g2.gain.exponentialRampToValueAtTime(0.001, t + 0.12);
  o2.connect(g2); g2.connect(out);
  o2.start(t); o2.stop(t + 0.14);
}

/* ---------------- 钟 ---------------- */
function sndBell(vol = 0.14, base = 196) {
  const a = audio(); if (!a) return;
  const t = a.currentTime;
  const out = bus(vol, 0.9);

  /* 非谐波分音，更接近真实铜钟 */
  const parts = [
    [1.00, 1.00],
    [1.51, 0.55],
    [2.03, 0.38],
    [2.67, 0.26],
    [3.51, 0.15],
    [5.12, 0.08]
  ];

  parts.forEach(([m, amp], i) => {
    const o = a.createOscillator();
    o.type = 'sine';
    const detune = 1 + (Math.random() - 0.5) * 0.004;
    o.frequency.setValueAtTime(base * m * detune, t);
    /* 极缓慢的下滑，模拟余韵 */
    o.frequency.linearRampToValueAtTime(base * m * detune * 0.9985, t + 4);

    const g = a.createGain();
    const dur = 7.0 / Math.pow(m, 0.72) + 1.1;
    g.gain.setValueAtTime(0, t);
    g.gain.linearRampToValueAtTime(amp * 0.48, t + 0.006);
    g.gain.exponentialRampToValueAtTime(0.0004, t + dur);

    o.connect(g); g.connect(out);
    o.start(t); o.stop(t + dur + 0.1);
  });
}

/* ---------------- 风铃 ---------------- */
function sndChime(vol = 0.05) {
  const a = audio(); if (!a) return;
  const t = a.currentTime;
  const out = bus(vol, 0.95);
  const base = 1250 + Math.random() * 1100;

  [1, 1.51, 2.13, 2.87].forEach((m, i) => {
    const o = a.createOscillator();
    o.type = 'sine';
    o.frequency.value = base * m * (1 + (Math.random() - 0.5) * 0.003);
    const g = a.createGain();
    const d = 2.6 / (1 + i * 0.55);
    g.gain.setValueAtTime(0, t);
    g.gain.linearRampToValueAtTime(0.42 / (i + 1), t + 0.004);
    g.gain.exponentialRampToValueAtTime(0.0003, t + d);
    o.connect(g); g.connect(out);
    o.start(t); o.stop(t + d + 0.05);
  });
}

/* ---------------- 古琴拨弦 ---------------- */
function sndPluck(vol = 0.06, freq = 220) {
  const a = audio(); if (!a) return;
  const t = a.currentTime;
  const out = bus(vol, 0.62);

  const o = a.createOscillator();
  o.type = 'triangle';
  o.frequency.value = freq;

  const o2 = a.createOscillator();
  o2.type = 'sine';
  o2.frequency.value = freq * 2.005;

  const lp = a.createBiquadFilter();
  lp.type = 'lowpass';
  lp.frequency.setValueAtTime(3400, t);
  lp.frequency.exponentialRampToValueAtTime(680, t + 1.7);
  lp.Q.value = 0.9;

  const g = a.createGain();
  g.gain.setValueAtTime(0, t);
  g.gain.linearRampToValueAtTime(1, t + 0.008);
  g.gain.exponentialRampToValueAtTime(0.0005, t + 2.3);

  const g2 = a.createGain();
  g2.gain.value = 0.22;

  o.connect(lp);
  o2.connect(g2); g2.connect(lp);
  lp.connect(g); g.connect(out);

  o.start(t); o.stop(t + 2.4);
  o2.start(t); o2.stop(t + 2.4);
}

/* ---------------- 环境低鸣（持续 drone） ---------------- */
function startDrone() {
  const a = audio(); if (!a || A.droneGain) return;
  const t = a.currentTime;

  const g = a.createGain();
  g.gain.value = 0;
  g.connect(A.master);

  const send = a.createGain();
  send.gain.value = 0.55;
  g.connect(send); send.connect(A.reverb);

  A.droneGain = g;

  const freqs = [73.4, 73.85, 110.0, 146.8, 220.4];
  const amps  = [0.30, 0.26, 0.17, 0.10, 0.045];

  freqs.forEach((f, i) => {
    const o = a.createOscillator();
    o.type = 'sine';
    o.frequency.value = f;

    const og = a.createGain();
    og.gain.value = amps[i];

    o.connect(og); og.connect(g);
    o.start(t);

    /* 缓慢幅度调制，产生呼吸感 */
    const lfo = a.createOscillator();
    lfo.type = 'sine';
    lfo.frequency.value = 0.028 + i * 0.017;
    const lg = a.createGain();
    lg.gain.value = amps[i] * 0.4;
    lfo.connect(lg); lg.connect(og.gain);
    lfo.start(t);
  });

  g.gain.linearRampToValueAtTime(0.38, t + 5);
}

function setDroneLevel(v, dur = 1.6) {
  if (!A.droneGain || !actx) return;
  const now = actx.currentTime;
  A.droneGain.gain.cancelScheduledValues(now);
  A.droneGain.gain.setValueAtTime(A.droneGain.gain.value, now);
  A.droneGain.gain.linearRampToValueAtTime(v, now + dur);
}

/* ---------------- 风声 ---------------- */
function startWind() {
  const a = audio(); if (!a || A.windGain) return;
  const t = a.currentTime;

  const src = a.createBufferSource();
  src.buffer = A.noise;
  src.loop = true;

  const bp = a.createBiquadFilter();
  bp.type = 'bandpass';
  bp.frequency.value = 520;
  bp.Q.value = 0.85;

  const lp = a.createBiquadFilter();
  lp.type = 'lowpass';
  lp.frequency.value = 1700;

  const g = a.createGain();
  g.gain.value = 0.05;
  A.windGain = g;

  src.connect(bp); bp.connect(lp); lp.connect(g);
  g.connect(A.master);

  const send = a.createGain();
  send.gain.value = 0.22;
  g.connect(send); send.connect(A.reverb);

  /* 滤波频率与音量缓慢漂移 */
  const lfo = a.createOscillator();
  lfo.type = 'sine';
  lfo.frequency.value = 0.067;
  const lg = a.createGain();
  lg.gain.value = 280;
  lfo.connect(lg); lg.connect(bp.frequency);
  lfo.start(t);

  const lfo2 = a.createOscillator();
  lfo2.type = 'sine';
  lfo2.frequency.value = 0.041;
  const lg2 = a.createGain();
  lg2.gain.value = 0.032;
  lfo2.connect(lg2); lg2.connect(g.gain);
  lfo2.start(t);

  src.start(t);
}

/* ---------------- 环境音调度 ---------------- */
let ambTimer = null;
const PENTA = [0, 2, 4, 7, 9, 12, 14, 16, 19, 21];

function scheduleAmbient() {
  clearTimeout(ambTimer);
  const delay = 8500 + Math.random() * 15000;
  ambTimer = setTimeout(() => {
    if (hasEntered && actx && !player.sitting) {
      const r = Math.random();
      if (r < 0.52) {
        const n = PENTA[Math.floor(Math.random() * PENTA.length)];
        sndPluck(0.045 + Math.random() * 0.03, 110 * Math.pow(2, n / 12));
      } else if (r < 0.84) {
        sndChime(0.028 + Math.random() * 0.022);
      } else {
        sndBell(0.032, 130.8);
      }
    }
    scheduleAmbient();
  }, delay);
}

/* =========================================================
   背景预渲染
   ========================================================= */
const bg = document.createElement('canvas');
bg.width = WORLD.w;
bg.height = WORLD.h;
const bx = bg.getContext('2d');

function buildBackground() {
  /* ---- 草地底色：以庭院为中心的径向渐变 ---- */
  const grd = bx.createRadialGradient(700, 720, 80, 700, 720, 940);
  grd.addColorStop(0, '#2b4335');
  grd.addColorStop(0.4, '#20362a');
  grd.addColorStop(0.75, '#182a20');
  grd.addColorStop(1, '#0e1711');
  bx.fillStyle = grd;
  bx.fillRect(0, 0, WORLD.w, WORLD.h);

  /* ---- 大块草色斑驳 ---- */
  for (let i = 0; i < 170; i++) {
    const x = rnd() * WORLD.w, y = rnd() * WORLD.h, r = rndRange(40, 190);
    const warm = rnd() > 0.55;
    const col = warm ? '92,126,88' : '26,52,38';
    const g = bx.createRadialGradient(x, y, 0, x, y, r);
    g.addColorStop(0, `rgba(${col},0.11)`);
    g.addColorStop(1, `rgba(${col},0)`);
    bx.fillStyle = g;
    bx.beginPath(); bx.arc(x, y, r, 0, Math.PI * 2); bx.fill();
  }

  /* ---- 细碎草叶 ---- */
  for (let i = 0; i < 3400; i++) {
    const x = rnd() * WORLD.w, y = rnd() * WORLD.h;
    if (x > PAD.x0 - 24 && x < PAD.x1 + 24 && y > 408 && y < PAD.y1 + 12) continue;
    const h = rndRange(3, 9);
    const lean = rndRange(-2.4, 2.4);
    const rr = 55 + rnd() * 45 | 0;
    const gg = 92 + rnd() * 55 | 0;
    const bb = 62 + rnd() * 38 | 0;
    bx.strokeStyle = `rgba(${rr},${gg},${bb},${(0.09 + rnd() * 0.17).toFixed(3)})`;
    bx.lineWidth = rndRange(0.6, 1.4);
    bx.beginPath();
    bx.moveTo(x, y);
    bx.quadraticCurveTo(x + lean * 0.5, y - h * 0.62, x + lean, y - h);
    bx.stroke();
  }

  /* ---- 中央庭院石板 ---- */
  drawCourtyard(bx);

  /* ---- 大殿 ---- */
  drawHall(bx);

  /* ---- 石灯（含光池） ---- */
  stoneLamps.forEach(l => drawStoneLamp(bx, l.x, l.y));
}

/* 庭院石板 */
function drawCourtyard(g) {
  const px0 = PAD.x0, py0 = 430, px1 = PAD.x1, py1 = PAD.y1;

  /* 外圈沙石过渡 */
  g.save();
  g.beginPath();
  g.moveTo(px0 - 26, py0 - 18);
  g.lineTo(px1 + 26, py0 - 18);
  g.lineTo(px1 + 34, py1 + 18);
  g.lineTo(px0 - 34, py1 + 18);
  g.closePath();
  g.fillStyle = 'rgba(58,56,50,0.28)';
  g.fill();
  g.restore();

  /* 石板区域裁剪 */
  g.save();
  g.beginPath();
  g.moveTo(px0 + 60, py0);
  g.lineTo(px1 - 60, py0);
  g.lineTo(px1, py0 + 70);
  g.lineTo(px1, py1 - 40);
  g.lineTo(px1 - 70, py1);
  g.lineTo(px0 + 70, py1);
  g.lineTo(px0, py1 - 40);
  g.lineTo(px0, py0 + 70);
  g.closePath();
  g.clip();

  g.fillStyle = '#3a3a39';
  g.fillRect(px0, py0, px1 - px0, py1 - py0);

  /* 石板格 */
  const cell = 78;
  for (let y = py0; y < py1; y += cell) {
    for (let x = px0; x < px1; x += cell) {
      const v = rnd();
      const r = 70 + v * 28 | 0;
      const gg = 70 + v * 26 | 0;
      const b = 66 + v * 24 | 0;
      g.fillStyle = `rgb(${r},${gg},${b})`;
      g.fillRect(x + 2, y + 2, cell - 4, cell - 4);

      /* 石面颗粒 */
      for (let k = 0; k < 8; k++) {
        g.fillStyle = `rgba(${rnd() > 0.5 ? 255 : 0},${rnd() > 0.5 ? 250 : 0},${rnd() > 0.5 ? 240 : 0},${(rnd() * 0.035).toFixed(3)})`;
        g.fillRect(x + rnd() * cell, y + rnd() * cell, rndRange(1, 3), rndRange(1, 2));
      }

      /* 石纹 */
      g.strokeStyle = 'rgba(0,0,0,0.075)';
      g.lineWidth = 1;
      g.beginPath();
      g.moveTo(x + 6, y + rndRange(10, cell - 10));
      g.lineTo(x + cell - 6, y + rndRange(10, cell - 10));
      g.stroke();

      /* 缝隙苔藓 */
      if (rnd() > 0.78) {
        g.fillStyle = `rgba(70,100,66,${(0.05 + rnd() * 0.09).toFixed(3)})`;
        g.beginPath();
        g.ellipse(x + rnd() * cell, y + rnd() * cell, rndRange(4, 13), rndRange(2, 7), rnd() * 3, 0, Math.PI * 2);
        g.fill();
      }
    }
  }

  /* 砖缝阴影线 */
  g.strokeStyle = 'rgba(0,0,0,0.22)';
  g.lineWidth = 1.6;
  for (let y = py0; y < py1; y += cell) {
    g.beginPath(); g.moveTo(px0, y); g.lineTo(px1, y); g.stroke();
  }
  for (let x = px0; x < px1; x += cell) {
    g.beginPath(); g.moveTo(x, py0); g.lineTo(x, py1); g.stroke();
  }

  /* 庭院中心磨损 */
  const rg = g.createRadialGradient(700, 720, 50, 700, 720, 460);
  rg.addColorStop(0, 'rgba(0,0,0,0.22)');
  rg.addColorStop(0.55, 'rgba(0,0,0,0.06)');
  rg.addColorStop(1, 'rgba(0,0,0,0)');
  g.fillStyle = rg;
  g.fillRect(px0, py0, px1 - px0, py1 - py0);

  g.restore();

  /* 边缘石条 */
  g.strokeStyle = 'rgba(126,122,108,0.4)';
  g.lineWidth = 3;
  g.beginPath();
  g.moveTo(px0 + 60, py0);
  g.lineTo(px1 - 60, py0);
  g.stroke();
}

/* 大殿 */
function drawHall(g) {
  /* 台基投影 */
  g.fillStyle = 'rgba(0,0,0,0.28)';
  g.beginPath();
  g.ellipse(700, 436, 330, 42, 0, 0, Math.PI * 2);
  g.fill();

  /* 台基 */
  g.fillStyle = '#33302a';
  g.beginPath();
  g.moveTo(392, 432); g.lineTo(1008, 432); g.lineTo(972, 386); g.lineTo(428, 386);
  g.closePath(); g.fill();

  g.fillStyle = '#3d3931';
  g.beginPath();
  g.moveTo(428, 386); g.lineTo(972, 386); g.lineTo(952, 372); g.lineTo(448, 372);
  g.closePath(); g.fill();

  /* 台基石缝 */
  g.strokeStyle = 'rgba(0,0,0,0.28)';
  g.lineWidth = 1;
  for (let i = 1; i < 9; i++) {
    const x = 392 + i * 68;
    g.beginPath(); g.moveTo(x, 432); g.lineTo(x + 4, 386); g.stroke();
  }

  /* 台阶 */
  g.fillStyle = '#454138';
  g.fillRect(636, 400, 128, 26);
  g.fillStyle = '#504b40';
  g.fillRect(636, 400, 128, 6);
  g.fillStyle = 'rgba(0,0,0,0.25)';
  g.fillRect(636, 424, 128, 3);
  /* 台阶中缝 */
  g.strokeStyle = 'rgba(0,0,0,0.3)';
  g.lineWidth = 1;
  g.beginPath(); g.moveTo(700, 400); g.lineTo(700, 426); g.stroke();

  /* 墙体 */
  g.fillStyle = '#6b5644';
  g.fillRect(468, 196, 464, 182);
  g.fillStyle = 'rgba(0,0,0,0.18)';
  g.fillRect(468, 196, 464, 46);

  /* 墙面木纹 */
  g.strokeStyle = 'rgba(0,0,0,0.09)';
  g.lineWidth = 1;
  for (let y = 202; y < 378; y += 9) {
    g.beginPath(); g.moveTo(468, y); g.lineTo(932, y); g.stroke();
  }

  /* 门洞 */
  g.fillStyle = '#241d17';
  g.fillRect(618, 248, 164, 132);

  /* 门框 */
  g.strokeStyle = '#8a6a4a';
  g.lineWidth = 4;
  g.strokeRect(616, 246, 168, 136);

  /* 殿内 */
  g.fillStyle = '#1a1410';
  g.fillRect(626, 256, 148, 124);

  /* 佛光 */
  const gl = g.createRadialGradient(700, 300, 4, 700, 300, 92);
  gl.addColorStop(0, 'rgba(235,195,115,0.6)');
  gl.addColorStop(0.4, 'rgba(200,155,70,0.24)');
  gl.addColorStop(1, 'rgba(200,155,70,0)');
  g.fillStyle = gl;
  g.fillRect(608, 208, 184, 184);

  /* 佛像 */
  g.fillStyle = '#c9a24a';
  g.beginPath(); g.arc(700, 296, 20, 0, Math.PI * 2); g.fill();
  g.beginPath(); g.ellipse(700, 299, 24, 10, 0, Math.PI, Math.PI * 2); g.fill();
  g.beginPath();
  g.moveTo(664, 382); g.lineTo(736, 382); g.lineTo(724, 318); g.lineTo(676, 318);
  g.closePath(); g.fill();

  /* 佛像高光 */
  g.fillStyle = 'rgba(255,235,180,0.30)';
  g.beginPath(); g.arc(694, 289, 8, 0, Math.PI * 2); g.fill();

  /* 莲座 */
  g.fillStyle = '#a8832f';
  g.beginPath();
  g.ellipse(700, 380, 46, 12, 0, 0, Math.PI * 2);
  g.fill();
  g.fillStyle = 'rgba(0,0,0,0.2)';
  g.beginPath();
  g.ellipse(700, 384, 40, 7, 0, 0, Math.PI * 2);
  g.fill();

  /* 柱子 */
  [478, 560, 826, 908].forEach(x => {
    g.fillStyle = '#7d6045';
    g.fillRect(x, 196, 15, 182);
    g.fillStyle = 'rgba(255,255,255,0.07)';
    g.fillRect(x, 196, 4, 182);
    g.fillStyle = 'rgba(0,0,0,0.22)';
    g.fillRect(x + 12, 196, 3, 182);
  });

  /* 横梁 */
  g.fillStyle = '#8a6a4a';
  g.fillRect(462, 190, 476, 12);
  g.fillStyle = 'rgba(0,0,0,0.25)';
  g.fillRect(462, 200, 476, 4);

  /* 屋顶 */
  g.fillStyle = '#20222a';
  g.beginPath();
  g.moveTo(406, 192);
  g.quadraticCurveTo(560, 128, 700, 96);
  g.quadraticCurveTo(840, 128, 994, 192);
  g.lineTo(1016, 204);
  g.lineTo(384, 204);
  g.closePath();
  g.fill();

  /* 屋檐阴影 */
  g.fillStyle = 'rgba(0,0,0,0.3)';
  g.fillRect(384, 196, 632, 10);

  /* 屋檐高光 */
  g.strokeStyle = '#3f4553';
  g.lineWidth = 3;
  g.beginPath();
  g.moveTo(384, 204); g.lineTo(1016, 204);
  g.stroke();

  /* 屋脊 */
  g.strokeStyle = '#4a5162';
  g.lineWidth = 5;
  g.beginPath();
  g.moveTo(420, 190);
  g.quadraticCurveTo(560, 130, 700, 100);
  g.quadraticCurveTo(840, 130, 980, 190);
  g.stroke();

  /* 瓦纹 */
  g.strokeStyle = 'rgba(255,255,255,0.05)';
  g.lineWidth = 1.5;
  for (let i = 0; i < 22; i++) {
    const t = i / 21;
    const x0 = 420 + t * 560;
    const y0 = 190 - Math.sin(t * Math.PI) * 82;
    g.beginPath();
    g.moveTo(x0, y0 + 4);
    g.lineTo(x0 + (700 - x0) * 0.12, y0 + 16);
    g.stroke();
  }

  /* 匾额 */
  g.fillStyle = '#2a2119';
  g.fillRect(660, 212, 80, 28);
  g.strokeStyle = '#a8874a';
  g.lineWidth = 1.5;
  g.strokeRect(662, 214, 76, 24);
  g.fillStyle = '#c9a860';
  g.font = '15px serif';
  g.textAlign = 'center';
  g.textBaseline = 'middle';
  g.fillText('云 水', 700, 227);

  /* 檐下灯笼 */
  drawHallLantern(g, 520, 214);
  drawHallLantern(g, 880, 214);
}

function drawHallLantern(g, x, y) {
  /* 吊线 */
  g.strokeStyle = 'rgba(70,58,40,0.85)';
  g.lineWidth = 1;
  g.beginPath(); g.moveTo(x, y - 18); g.lineTo(x, y); g.stroke();

  /* 光晕 */
  const gl = g.createRadialGradient(x, y + 7, 1, x, y + 7, 34);
  gl.addColorStop(0, 'rgba(255,175,85,0.42)');
  gl.addColorStop(1, 'rgba(255,175,85,0)');
  g.fillStyle = gl;
  g.beginPath(); g.arc(x, y + 7, 34, 0, Math.PI * 2); g.fill();

  /* 灯体 */
  g.fillStyle = '#5a2a14';
  g.beginPath();
  g.ellipse(x, y + 7, 8, 10, 0, 0, Math.PI * 2);
  g.fill();
  g.fillStyle = 'rgba(255,170,80,0.75)';
  g.beginPath();
  g.ellipse(x, y + 7, 5, 7, 0, 0, Math.PI * 2);
  g.fill();

  /* 顶盖 */
  g.fillStyle = '#33281c';
  g.fillRect(x - 6, y - 2, 12, 3);
  g.fillRect(x - 5, y + 15, 10, 2);
}

function drawStoneLamp(g, x, y) {
  /* 地面光池 */
  const pool = g.createRadialGradient(x, y - 4, 4, x, y - 4, 96);
  pool.addColorStop(0, 'rgba(240,185,95,0.20)');
  pool.addColorStop(0.5, 'rgba(240,185,95,0.07)');
  pool.addColorStop(1, 'rgba(240,185,95,0)');
  g.fillStyle = pool;
  g.beginPath(); g.ellipse(x, y - 4, 96, 44, 0, 0, Math.PI * 2); g.fill();

  /* 底座 */
  g.fillStyle = '#2d2c28';
  g.beginPath(); g.ellipse(x, y, 16, 6, 0, 0, Math.PI * 2); g.fill();
  g.fillRect(x - 5, y - 34, 10, 34);

  /* 柱身石缝 */
  g.fillStyle = 'rgba(255,255,255,0.05)';
  g.fillRect(x - 5, y - 34, 3, 34);

  g.fillStyle = '#35342f';
  g.beginPath(); g.ellipse(x, y - 34, 13, 6, 0, 0, Math.PI * 2); g.fill();

  /* 灯室 */
  g.fillStyle = '#2a2925';
  g.fillRect(x - 11, y - 58, 22, 22);
  g.fillStyle = 'rgba(245,195,105,0.6)';
  g.fillRect(x - 7, y - 54, 14, 14);

  /* 灯芯 */
  g.fillStyle = 'rgba(255,235,190,0.85)';
  g.beginPath(); g.arc(x, y - 47, 3.2, 0, Math.PI * 2); g.fill();

  /* 顶盖 */
  g.fillStyle = '#35342f';
  g.beginPath();
  g.moveTo(x - 17, y - 58); g.lineTo(x, y - 74); g.lineTo(x + 17, y - 58);
  g.closePath(); g.fill();
  g.strokeStyle = 'rgba(255,255,255,0.07)';
  g.lineWidth = 1;
  g.beginPath(); g.moveTo(x - 15, y - 58); g.lineTo(x, y - 71); g.stroke();

  /* 光晕 */
  const gg = g.createRadialGradient(x, y - 47, 2, x, y - 47, 52);
  gg.addColorStop(0, 'rgba(245,195,105,0.30)');
  gg.addColorStop(0.45, 'rgba(240,180,90,0.09)');
  gg.addColorStop(1, 'rgba(240,180,90,0)');
  g.fillStyle = gg;
  g.beginPath(); g.arc(x, y - 47, 52, 0, Math.PI * 2); g.fill();
}

/* =========================================================
   动态绘制
   ========================================================= */

/* ---- 光尘 ---- */
const dust = [];
for (let i = 0; i < 80; i++) {
  dust.push({
    x: rndRange(0, WORLD.w),
    y: rndRange(0, WORLD.h),
    r: rndRange(0.6, 2.2),
    sp: rndRange(4, 17),
    ph: rndRange(0, Math.PI * 2),
    sw: rndRange(6, 24)
  });
}

/* ---- 飘落花瓣 / 叶 ---- */
const petals = [];
function initPetals() {
  petals.length = 0;
  for (let i = 0; i < 24; i++) {
    petals.push({
      x: rndRange(0, WORLD.w),
      y: rndRange(-WORLD.h, WORLD.h),
      r: rndRange(2.4, 5.2),
      vy: rndRange(9, 24),
      vx: rndRange(-9, 9),
      sw: rndRange(10, 30),
      ph: rndRange(0, Math.PI * 2),
      rot: rndRange(0, Math.PI * 2),
      vr: rndRange(-1.4, 1.4),
      a: rndRange(0.18, 0.45),
      col: rnd() > 0.55 ? '#c8a94e' : '#9bb06a'
    });
  }
}

function updatePetals(dt, now) {
  petals.forEach(p => {
    p.y += p.vy * dt;
    p.x += (p.vx + Math.sin(now * 0.0008 + p.ph) * p.sw * 0.4) * dt;
    p.rot += p.vr * dt;
    if (p.y > WORLD.h + 30) { p.y = -30; p.x = rndRange(0, WORLD.w); }
    if (p.x < -30) p.x = WORLD.w + 30;
    if (p.x > WORLD.w + 30) p.x = -30;
  });
}

function drawPetal(g, p) {
  g.save();
  g.translate(p.x, p.y);
  g.rotate(p.rot);
  g.globalAlpha = p.a;
  g.fillStyle = p.col;
  g.beginPath();
  g.moveTo(-p.r, 0);
  g.quadraticCurveTo(0, -p.r * 0.82, p.r, 0);
  g.quadraticCurveTo(0, p.r * 0.82, -p.r, 0);
  g.fill();
  g.restore();
  g.globalAlpha = 1;
}

/* ---- 树 ---- */
function drawTree(g, t, now) {
  const sway = Math.sin(now * 0.0009 + t.x * 0.02) * 3.5;
  const sway2 = Math.sin(now * 0.0013 + t.x * 0.017) * 2.2;

  /* 地面柔影 */
  g.fillStyle = 'rgba(0,0,0,0.17)';
  g.beginPath();
  g.ellipse(t.x, t.y + 3, 48, 15, 0, 0, Math.PI * 2);
  g.fill();

  /* 树干 */
  g.fillStyle = '#2f2318';
  g.beginPath();
  g.moveTo(t.x - 9, t.y + 2);
  g.quadraticCurveTo(t.x - 6, t.y - 40, t.x - 5, t.y - 70);
  g.lineTo(t.x + 5, t.y - 70);
  g.quadraticCurveTo(t.x + 6, t.y - 40, t.x + 9, t.y + 2);
  g.closePath();
  g.fill();

  /* 树干受光 */
  g.fillStyle = 'rgba(135,100,62,0.22)';
  g.beginPath();
  g.moveTo(t.x - 9, t.y + 2);
  g.quadraticCurveTo(t.x - 6, t.y - 40, t.x - 5, t.y - 70);
  g.lineTo(t.x - 1, t.y - 70);
  g.quadraticCurveTo(t.x - 2, t.y - 40, t.x - 3, t.y + 2);
  g.closePath();
  g.fill();

  /* 树冠：由暗到亮的多层圆斑 */
  const blobs = [
    [t.x - 20 + sway2, t.y - 92,  32, '#1a3322'],
    [t.x + 22 + sway2, t.y - 90,  30, '#1a3322'],
    [t.x + sway,       t.y - 104, 46, '#17301f'],
    [t.x - 14 + sway,  t.y - 118, 30, '#22452b'],
    [t.x + 16 + sway,  t.y - 112, 26, '#22452b'],
    [t.x - 4 + sway,   t.y - 132, 24, '#2b5436'],
    [t.x + 11 + sway,  t.y - 126, 18, '#35603d']
  ];
  blobs.forEach(([x, y, r, c]) => {
    g.fillStyle = c;
    g.beginPath(); g.arc(x, y, r, 0, Math.PI * 2); g.fill();
  });

  /* 顶部受光 */
  g.fillStyle = 'rgba(150,200,158,0.10)';
  g.beginPath();
  g.arc(t.x - 8 + sway * 1.2, t.y - 140, 16, 0, Math.PI * 2);
  g.fill();
  g.fillStyle = 'rgba(180,220,180,0.06)';
  g.beginPath();
  g.arc(t.x + 12 + sway, t.y - 128, 10, 0, Math.PI * 2);
  g.fill();
}

/* ---- 蒲团 ---- */
function drawCushion(g, c) {
  g.fillStyle = 'rgba(0,0,0,0.24)';
  g.beginPath(); g.ellipse(c.x, c.y + 4, 31, 12, 0, 0, Math.PI * 2); g.fill();

  g.fillStyle = '#6b4a2f';
  g.beginPath(); g.ellipse(c.x, c.y, 28, 10, 0, 0, Math.PI * 2); g.fill();

  g.fillStyle = '#8a6238';
  g.beginPath(); g.ellipse(c.x, c.y - 3, 26, 9, 0, 0, Math.PI * 2); g.fill();

  /* 顶部柔光 */
  g.fillStyle = 'rgba(255,220,160,0.10)';
  g.beginPath(); g.ellipse(c.x - 5, c.y - 5, 14, 4, -0.2, 0, Math.PI * 2); g.fill();

  g.strokeStyle = 'rgba(200,160,90,0.30)';
  g.lineWidth = 1.5;
  g.beginPath(); g.ellipse(c.x, c.y - 3, 18, 6, 0, 0, Math.PI * 2); g.stroke();
}

/* ---- 香炉 ---- */
function drawIncense(g, now) {
  const x = 700, y = 585;

  g.fillStyle = 'rgba(0,0,0,0.25)';
  g.beginPath(); g.ellipse(x, y + 3, 36, 12, 0, 0, Math.PI * 2); g.fill();

  /* 炉身 */
  g.fillStyle = '#3b3630';
  g.beginPath();
  g.moveTo(x - 30, y - 30);
  g.lineTo(x + 30, y - 30);
  g.lineTo(x + 22, y);
  g.lineTo(x - 22, y);
  g.closePath();
  g.fill();

  /* 炉身纹饰 */
  g.strokeStyle = 'rgba(200,175,110,0.16)';
  g.lineWidth = 1.4;
  g.beginPath();
  g.moveTo(x - 27, y - 22); g.lineTo(x + 27, y - 22);
  g.stroke();
  g.beginPath();
  g.moveTo(x - 24, y - 12); g.lineTo(x + 24, y - 12);
  g.stroke();

  /* 炉口 */
  g.fillStyle = '#514a40';
  g.beginPath(); g.ellipse(x, y - 30, 30, 10, 0, 0, Math.PI * 2); g.fill();
  g.fillStyle = '#26221d';
  g.beginPath(); g.ellipse(x, y - 30, 24, 7, 0, 0, Math.PI * 2); g.fill();

  /* 三足 */
  g.fillStyle = '#332f29';
  [-18, 0, 18].forEach(dx => {
    g.fillRect(x + dx - 3, y - 6, 6, 12);
  });

  /* 香灰微光 */
  const flick = 0.62 + Math.sin(now * 0.0041) * 0.22;
  const glow = g.createRadialGradient(x, y - 30, 1, x, y - 30, 26);
  glow.addColorStop(0, `rgba(255,155,65,${0.42 * flick})`);
  glow.addColorStop(1, 'rgba(255,155,65,0)');
  g.fillStyle = glow;
  g.beginPath(); g.arc(x, y - 30, 26, 0, Math.PI * 2); g.fill();

  /* 青烟 */
  for (let i = 0; i < 16; i++) {
    const tt = ((now * 0.00021 + i / 16) % 1);
    const yy = y - 34 - tt * 160;
    const xx = x + Math.sin(tt * 7 + i * 0.9) * (10 + tt * 30);
    const a = (1 - tt) * 0.15;
    const r = 4 + tt * 22;
    g.fillStyle = `rgba(216,216,206,${a})`;
    g.beginPath(); g.arc(xx, yy, r, 0, Math.PI * 2); g.fill();
  }
}

/* ---- 玩家 ---- */
function drawPlayer(g, now) {
  const p = player;
  const sit = p.sitAmt;
  const bow = p.bowAmt;
  const hand = p.handAmt;

  const spd = Math.hypot(p.vx, p.vy);
  const moving = spd > 12 ? 1 : 0;
  const bob = moving ? Math.sin(p.walkPhase * 10) * 1.7 : Math.sin(now * 0.0018) * 0.7;

  /* 影子 */
  const shW = 17 + sit * 10;
  g.fillStyle = 'rgba(0,0,0,0.30)';
  g.beginPath();
  g.ellipse(p.x, p.y, shW, 6 + sit * 2, 0, 0, Math.PI * 2);
  g.fill();

  const baseH = 54;
  const h = baseH * (1 - sit * 0.46 - bow * 0.52);
  const topY = p.y - h - bob * (1 - sit);

  /* ---- 腿 / 盘坐 ---- */
  if (sit > 0.4) {
    g.fillStyle = '#7a5330';
    g.beginPath();
    g.ellipse(p.x, p.y - 5, 23, 9.5, 0, 0, Math.PI * 2);
    g.fill();
    g.fillStyle = 'rgba(0,0,0,0.18)';
    g.beginPath();
    g.ellipse(p.x, p.y - 2, 23, 7, 0, 0, Math.PI * 2);
    g.fill();
    /* 膝盖 */
    g.fillStyle = '#8a5f37';
    g.beginPath(); g.ellipse(p.x - 16, p.y - 7, 8, 5.5, -0.3, 0, Math.PI * 2); g.fill();
    g.beginPath(); g.ellipse(p.x + 16, p.y - 7, 8, 5.5, 0.3, 0, Math.PI * 2); g.fill();
  } else {
    const legSwing = moving ? Math.sin(p.walkPhase * 10) * 3.4 : 0;
    g.fillStyle = '#4a3520';
    g.fillRect(p.x - 9 - legSwing, p.y - 16, 7, 16 + legSwing * 0.4);
    g.fillRect(p.x + 2 + legSwing, p.y - 16, 7, 16 - legSwing * 0.4);
    /* 鞋 */
    g.fillStyle = '#2d2116';
    g.beginPath();
    g.ellipse(p.x - 5.5 - legSwing, p.y - 1.5, 5, 2.6, 0, 0, Math.PI * 2);
    g.fill();
    g.beginPath();
    g.ellipse(p.x + 5.5 + legSwing, p.y - 1.5, 5, 2.6, 0, 0, Math.PI * 2);
    g.fill();
  }

  /* ---- 袈裟 ---- */
  const bodyTop = topY + 13;
  const bodyBottomY = p.y - 12 * sit;

  g.fillStyle = '#9c6b3f';
  g.beginPath();
  g.moveTo(p.x - 14, bodyBottomY);
  g.lineTo(p.x + 14, bodyBottomY);
  g.lineTo(p.x + 9, bodyTop);
  g.lineTo(p.x - 9, bodyTop);
  g.closePath();
  g.fill();

  /* 衣褶 */
  g.strokeStyle = 'rgba(0,0,0,0.14)';
  g.lineWidth = 1;
  for (let i = -1; i <= 1; i++) {
    g.beginPath();
    g.moveTo(p.x + i * 5, bodyTop + 4);
    g.lineTo(p.x + i * 5.5, bodyBottomY - 2);
    g.stroke();
  }

  /* 斜襟 */
  g.fillStyle = '#754c28';
  g.beginPath();
  g.moveTo(p.x - 9, bodyTop + 1);
  g.lineTo(p.x + 9, bodyTop + 1);
  g.lineTo(p.x + 4, p.y - 10 * sit);
  g.lineTo(p.x - 6, p.y - 10 * sit);
  g.closePath();
  g.fill();

  /* 腰带 */
  g.fillStyle = '#5c3d20';
  g.beginPath();
  g.moveTo(p.x - 10.5, bodyBottomY - 12 * (1 - sit));
  g.lineTo(p.x + 10.5, bodyBottomY - 12 * (1 - sit));
  g.lineTo(p.x + 10.5, bodyBottomY - 8 * (1 - sit));
  g.lineTo(p.x - 10.5, bodyBottomY - 8 * (1 - sit));
  g.closePath();
  g.fill();

  /* 肩部受光 */
  g.fillStyle = 'rgba(235,185,125,0.18)';
  g.beginPath();
  g.moveTo(p.x - 14, bodyBottomY);
  g.lineTo(p.x - 9, bodyTop);
  g.lineTo(p.x - 3, bodyTop);
  g.lineTo(p.x - 7, bodyBottomY);
  g.closePath();
  g.fill();

  /* ---- 头 ---- */
  const headR = 11 * (1 - bow * 0.22);
  const headY = topY + 3 - bow * 5;

  /* 脖子 */
  g.fillStyle = '#dcc0a0';
  g.fillRect(p.x - 3, headY + headR - 3, 6, 6);

  g.fillStyle = '#f0d3b3';
  g.beginPath(); g.arc(p.x, headY, headR, 0, Math.PI * 2); g.fill();

  /* 头顶光 */
  g.fillStyle = 'rgba(255,255,255,0.15)';
  g.beginPath();
  g.arc(p.x - headR * 0.3, headY - headR * 0.38, headR * 0.55, 0, Math.PI * 2);
  g.fill();

  /* 五官 */
  if (bow < 0.45 && sit < 0.85) {
    g.fillStyle = '#2a2018';
    g.beginPath(); g.arc(p.x - 4, headY + 1.5, 1.4, 0, Math.PI * 2); g.fill();
    g.beginPath(); g.arc(p.x + 4, headY + 1.5, 1.4, 0, Math.PI * 2); g.fill();
    g.strokeStyle = 'rgba(150,110,80,0.7)';
    g.lineWidth = 1;
    g.beginPath();
    g.arc(p.x, headY + 5, 3.2, 0.25, Math.PI - 0.25);
    g.stroke();
  } else {
    g.strokeStyle = '#8a6a50';
    g.lineWidth = 1.2;
    g.beginPath(); g.moveTo(p.x - 6, headY + 2); g.lineTo(p.x - 2, headY + 2); g.stroke();
    g.beginPath(); g.moveTo(p.x + 2, headY + 2); g.lineTo(p.x + 6, headY + 2); g.stroke();
  }

  /* ---- 合掌的手 ---- */
  if (hand > 0.02) {
    const hy = topY + 24 - sit * 4;
    g.save();
    g.translate(p.x, hy);
    /* 手掌 */
    g.fillStyle = '#f0d3b3';
    g.beginPath();
    g.ellipse(-2.6 * hand, 0, 3.2 * hand, 7 * hand, -0.12, 0, Math.PI * 2);
    g.fill();
    g.beginPath();
    g.ellipse(2.6 * hand, 0, 3.2 * hand, 7 * hand, 0.12, 0, Math.PI * 2);
    g.fill();
    /* 指缝光 */
    g.strokeStyle = 'rgba(190,150,110,0.55)';
    g.lineWidth = 0.8;
    g.beginPath();
    g.moveTo(0, -6 * hand); g.lineTo(0, 6 * hand);
    g.stroke();
    g.restore();
  }
}

/* ---- 光尘 ---- */
function drawDust(g, now) {
  dust.forEach(d => {
    const y = ((d.y - now * 0.001 * d.sp) % WORLD.h + WORLD.h) % WORLD.h;
    const x = d.x + Math.sin(now * 0.0006 + d.ph) * d.sw;
    const a = 0.16 + Math.sin(now * 0.002 + d.ph) * 0.12;
    g.fillStyle = `rgba(232,218,172,${Math.max(0.03, a).toFixed(3)})`;
    g.beginPath(); g.arc(x, y, d.r, 0, Math.PI * 2); g.fill();
  });
}

/* =========================================================
   更新逻辑
   ========================================================= */
function update(dt) {
  const p = player;
  const now = performance.now();

  /* 输入向量 */
  let ix = 0, iy = 0;
  if (keys['a'] || keys['arrowleft']) ix -= 1;
  if (keys['d'] || keys['arrowright']) ix += 1;
  if (keys['w'] || keys['arrowup']) iy -= 1;
  if (keys['s'] || keys['arrowdown']) iy += 1;
  ix += stick.dx;
  iy += stick.dy;

  const len = Math.hypot(ix, iy);
  if (len > 1) { ix /= len; iy /= len; }

  if (p.sitting) { ix = 0; iy = 0; }

  const targetVx = ix * p.speed;
  const targetVy = iy * p.speed * 0.78;
  p.vx += (targetVx - p.vx) * Math.min(1, dt * 12);
  p.vy += (targetVy - p.vy) * Math.min(1, dt * 12);

  p.x += p.vx * dt;
  p.y += p.vy * dt;

  if (Math.hypot(p.vx, p.vy) > 10) {
    p.walkPhase += dt * (Math.hypot(p.vx, p.vy) / p.speed);
  }

  /* 边界 */
  p.x = clamp(p.x, 56, WORLD.w - 56);
  p.y = clamp(p.y, 434, WORLD.h - 36);

  /* 树的软碰撞 */
  for (const t of trees) {
    const dx = p.x - t.x;
    const dy = (p.y - t.y) * 1.7;
    const d = Math.hypot(dx, dy);
    const R = 30;
    if (d < R && d > 0.001) {
      p.x = t.x + (dx / d) * R;
      p.y = t.y + (dy / d) * R / 1.7;
    }
  }

  /* 动画插值 */
  p.handAmt += (p.handTarget - p.handAmt) * Math.min(1, dt * 10);
  p.bowAmt += (p.bowTarget - p.bowAmt) * Math.min(1, dt * 9);
  p.sitAmt += ((p.sitting ? 1 : 0) - p.sitAmt) * Math.min(1, dt * 4);

  /* 计时器 */
  if (p.handTimer > 0) {
    p.handTimer -= dt;
    if (p.handTimer <= 0) p.handTarget = 0;
  }
  if (p.bowTimer > 0) {
    p.bowTimer -= dt;
    if (p.bowTimer <= 0) p.bowTarget = 0;
  }

  /* 摄像机 */
  const cx = W >= WORLD.w ? WORLD.w / 2 : clamp(p.x, W / 2, WORLD.w - W / 2);
  const cy = H >= WORLD.h ? WORLD.h / 2 : clamp(p.y, H / 2, WORLD.h - H / 2);
  cam.x += (cx - cam.x) * Math.min(1, dt * 5);
  cam.y += (cy - cam.y) * Math.min(1, dt * 5);

  /* 花瓣 */
  updatePetals(dt, now);
}

/* =========================================================
   渲染
   ========================================================= */
function render(now) {
  ctx.clearRect(0, 0, W, H);

  ctx.save();
  ctx.translate(W / 2 - cam.x, H / 2 - cam.y);

  /* 背景（只绘制可见区域） */
  const sx = Math.max(0, Math.floor(cam.x - W / 2));
  const sy = Math.max(0, Math.floor(cam.y - H / 2));
  const sw = Math.min(WORLD.w - sx, Math.ceil(W) + 2);
  const sh = Math.min(WORLD.h - sy, Math.ceil(H) + 2);
  if (sw > 0 && sh > 0) ctx.drawImage(bg, sx, sy, sw, sh, sx, sy, sw, sh);

  /* 深度排序绘制 */
  const objs = [];
  trees.forEach(t => objs.push({ y: t.y, fn: () => drawTree(ctx, t, now) }));
  cushions.forEach(c => objs.push({ y: c.y, fn: () => drawCushion(ctx, c) }));
  objs.push({ y: 585, fn: () => drawIncense(ctx, now) });
  objs.push({ y: player.y, fn: () => drawPlayer(ctx, now) });

  objs.sort((a, b) => a.y - b.y);
  objs.forEach(o => o.fn());

  /* 花瓣 */
  petals.forEach(p => drawPetal(ctx, p));

  /* 光尘 */
  drawDust(ctx, now);

  ctx.restore();

  /* 屏幕空间：底部暖色微光 */
  const grad = ctx.createLinearGradient(0, H * 0.55, 0, H);
  grad.addColorStop(0, 'rgba(255,185,105,0)');
  grad.addColorStop(1, 'rgba(150,95,35,0.055)');
  ctx.fillStyle = grad;
  ctx.fillRect(0, 0, W, H);
}

/* =========================================================
   动作
   ========================================================= */
function actHand() {
  audio();
  player.handTarget = 1;
  player.handTimer = 1.6;
  sndChime(0.045);
  setTimeout(() => sndPluck(0.035, 330), 90);
}

function actBow() {
  audio();
  player.bowTarget = 1;
  player.bowTimer = 1.3;
  sndWood(0.18, 1);
  setTimeout(() => sndWood(0.10, 0.94), 260);
}

/* =========================================================
   念珠
   ========================================================= */
const N_BEADS = 18;
const beadPanel = document.getElementById('beadPanel');
const malaEl = document.getElementById('mala');
const beadNEl = document.getElementById('beadN');

const beadPosEls = [];
const beadCoreEls = [];

let ringAngle = 180;
let beadPos = 0;
let beadCount = 0;
let lastPluck = 0;
let activeTimer = null;

for (let i = 0; i < N_BEADS; i++) {
  const pos = document.createElement('div');
  pos.className = 'bead-pos';
  const core = document.createElement('div');
  core.className = 'bead' + (i === 0 ? ' master' : '');
  pos.appendChild(core);
  malaEl.appendChild(pos);
  beadPosEls.push(pos);
  beadCoreEls.push(core);
}

function ringR() {
  return malaEl.clientWidth * 0.38;
}

function layoutRing() {
  const R = ringR();
  beadPosEls.forEach((el, i) => {
    const a = i * (360 / N_BEADS) + ringAngle;
    el.style.transform = `rotate(${a}deg) translateY(-${R}px)`;
  });
}

function updateActive(delay) {
  clearTimeout(activeTimer);
  const apply = () => {
    beadPosEls.forEach((el, i) => el.classList.toggle('active', i === beadPos));
  };
  if (delay) activeTimer = setTimeout(apply, delay);
  else apply();
}

function pluck() {
  const now = performance.now();
  if (now - lastPluck < 90) return;
  lastPluck = now;

  audio();

  const core = beadCoreEls[beadPos];
  core.classList.add('pluck');
  setTimeout(() => core.classList.remove('pluck'), 190);

  beadPos = (beadPos + 1) % N_BEADS;
  ringAngle -= 360 / N_BEADS;
  layoutRing();
  updateActive(210);

  beadCount++;
  beadNEl.textContent = beadCount;
  beadNEl.classList.add('pop');
  setTimeout(() => beadNEl.classList.remove('pop'), 160);

  /* 音高随拨动颗数轻微起伏，避免机械重复 */
  const pitch = 0.94 + ((beadCount * 7) % 11) * 0.012;
  sndWood(0.16, pitch);

  if (beadPos === 0) {
    setTimeout(() => sndBell(0.10, 196), 380);
  }
}

malaEl.addEventListener('click', pluck);

/* 打开/收起念珠面板 */
const beadBtn = document.querySelector('.acts button[data-act="bead"]');
const beadCloseBtn = document.getElementById('beadClose');

function openBeadPanel() {
  audio();
  beadPanel.classList.add('on');
  beadBtn.classList.add('dis');
  layoutRing();
  updateActive(0);
  player.handTarget = 1;
  player.handTimer = 1.2;
}

function closeBeadPanel() {
  beadPanel.classList.remove('on');
  beadBtn.classList.remove('dis');
}

function toggleBeadPanel() {
  if (beadPanel.classList.contains('on')) closeBeadPanel();
  else openBeadPanel();
}

beadCloseBtn.addEventListener('click', e => {
  e.stopPropagation();
  closeBeadPanel();
});

cvs.addEventListener('pointerdown', () => {
  if (beadPanel.classList.contains('on')) closeBeadPanel();
});

window.addEventListener('keydown', e => {
  if (e.key === 'Escape' && beadPanel.classList.contains('on')) closeBeadPanel();
});

/* =========================================================
   坐禅
   ========================================================= */
const sitOverlay = document.getElementById('sitOverlay');
const sitTimeEl = document.getElementById('sitTime');
let sitStart = 0;
let sitTimerId = null;

function enterSit() {
  audio();
  if (player.sitting) return;
  player.sitting = true;
  player.handTarget = 1;
  player.handTimer = 999;
  closeBeadPanel();

  sitOverlay.classList.add('on');
  sitStart = performance.now();
  sndBell(0.10, 174.6);
  setDroneLevel(0.62, 2.6);

  /* 远处风铃，营造空间感 */
  setTimeout(() => sndChime(0.03), 1800);

  sitTimerId = setInterval(() => {
    const s = Math.floor((performance.now() - sitStart) / 1000);
    const m = String(Math.floor(s / 60)).padStart(2, '0');
    const ss = String(s % 60).padStart(2, '0');
    sitTimeEl.textContent = `${m}:${ss}`;
  }, 250);
}

function exitSit() {
  if (!player.sitting) return;
  player.sitting = false;
  player.handTarget = 0;
  player.handTimer = 0;
  sitOverlay.classList.remove('on');
  clearInterval(sitTimerId);
  setDroneLevel(0.38, 2.0);
  sndBell(0.055, 196);
}

sitOverlay.addEventListener('click', exitSit);

/* =========================================================
   按钮绑定
   ========================================================= */
document.querySelectorAll('.acts button').forEach(btn => {
  btn.addEventListener('click', () => {
    audio();
    const act = btn.dataset.act;
    if (act === 'hand') actHand();
    else if (act === 'bow') actBow();
    else if (act === 'bead') toggleBeadPanel();
    else if (act === 'sit') enterSit();
  });
});

/* =========================================================
   开场
   ========================================================= */
const intro = document.getElementById('intro');
const enterBtn = document.getElementById('enterBtn');
const introName = document.getElementById('introName');
const famingEl = document.getElementById('faming');

let hasEntered = false;

function enterWorld() {
  if (hasEntered) return;
  hasEntered = true;
  audio();
  startDrone();
  startWind();
  scheduleAmbient();

  intro.classList.remove('on');
  intro.style.pointerEvents = 'none';
  setTimeout(() => { intro.style.display = 'none'; }, 1000);

  sndBell(0.12, 196);
  setTimeout(() => sndChime(0.035), 1400);
}

enterBtn.addEventListener('click', enterWorld);

/* =========================================================
   主循环
   ========================================================= */
let lastT = performance.now();

function loop(now) {
  const dt = Math.min((now - lastT) / 1000, 0.05);
  lastT = now;

  if (hasEntered) update(dt);
  render(now);

  requestAnimationFrame(loop);
}

/* =========================================================
   启动
   ========================================================= */
function boot() {
  resize();
  buildBackground();
  initPetals();
  layoutRing();
  updateActive(0);

  const nm = makeName();
  introName.textContent = nm;
  famingEl.textContent = nm;

  cam.x = player.x;
  cam.y = player.y;

  requestAnimationFrame(loop);
}

window.addEventListener('resize', () => {
  resize();
  layoutRing();
});

document.addEventListener('gesturestart', e => e.preventDefault());

boot();
</script>
</body>
</html>
