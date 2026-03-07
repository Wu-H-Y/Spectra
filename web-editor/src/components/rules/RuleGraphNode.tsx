import { Handle, Position, type NodeProps } from '@xyflow/react';

import { Badge } from '@/components/ui/badge';
import type { RuleGraphNode as RuleGraphNodeModel } from '@/lib/ruleGraph';
import { cn } from '@/lib/utils';

const PORT_SPACING = 28;
const PORT_START = 74;

const RuleGraphNode = ({ data, selected }: NodeProps<RuleGraphNodeModel>) => {
  const maxPortCount = Math.max(data.inputs.length, data.outputs.length, 1);
  const contentMinHeight = maxPortCount * PORT_SPACING;

  return (
    <div
      className={cn(
        'min-w-60 rounded-xl border bg-card px-4 py-3 text-card-foreground shadow-sm transition-colors',
        selected && 'border-primary shadow-md',
      )}
    >
      <div className="flex items-center justify-between gap-2">
        <div>
          <div className="text-sm font-semibold">{data.label}</div>
          <div className="text-xs text-muted-foreground">{data.kindType}</div>
        </div>
        <Badge variant="secondary">{data.phase}</Badge>
      </div>

      <div
        className="mt-3 grid grid-cols-2 gap-x-6 gap-y-1 text-xs"
        style={{ minHeight: `${contentMinHeight}px` }}
      >
        <div className="space-y-1">
          {data.inputs.map((port, index) => (
            <div
              key={port.name}
              className="relative rounded-md bg-muted/60 px-2 py-1"
            >
              <Handle
                type="target"
                position={Position.Left}
                id={port.name}
                style={{ top: PORT_START + index * PORT_SPACING }}
              />
              <div className="font-medium">{port.name}</div>
              <div className="text-[11px] text-muted-foreground">
                {port.dataType.type}
              </div>
            </div>
          ))}
        </div>

        <div className="space-y-1">
          {data.outputs.map((port, index) => (
            <div
              key={port.name}
              className="relative rounded-md bg-primary/5 px-2 py-1 text-right"
            >
              <Handle
                type="source"
                position={Position.Right}
                id={port.name}
                style={{ top: PORT_START + index * PORT_SPACING }}
              />
              <div className="font-medium">{port.name}</div>
              <div className="text-[11px] text-muted-foreground">
                {port.dataType.type}
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default RuleGraphNode;
